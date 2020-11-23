//
//  ServerManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

public class DefaultServerManager: ServerManager {
    public var id: Int { settings.id }
    public var name: String { settings.displayName }
    public var settings: ServerSettings { ServerSettings(managed: settingsManager.serverSettingsManaged.value) }
    
    private let settingsManager: CoreDataServerSettingsManager
    public let status = CurrentValueSubject<ServerStatus, Error>(.disconnected)
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverSettings: DB_ServerSettings) {
        settingsManager = CoreDataServerSettingsManager(serverSettings: serverSettings)
    }
    
    public func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<ServerSettings, Error> {
        settingsManager.updateServerSettings(serverSettings)
            .map { _ in
                return serverSettings
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteServer() -> AnyPublisher<Void, Error> {
        settingsManager.deleteServer()
    }
    
    static func create(_ settings: ServerSettings, inContext context: NSManagedObjectContext) -> AnyPublisher<DefaultServerManager, Error> {
        let serverSettings = DB_ServerSettings(context: context)
        _ = settings.updateManaged(serverSettings)
        
        return context.savePublisher()
            .map { _ -> DefaultServerManager in
                DefaultServerManager(serverSettings: serverSettings)
            }
            .eraseToAnyPublisher()
    }
}
