//
//  ServerManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

public class ServerManager: Identifiable {
    public var id: Int {
        return ServerSettings(managed: settingsManager.serverSettingsManaged.value).id
    }
    
    public var name: String {
        ServerSettings(managed: settingsManager.serverSettingsManaged.value).displayName
    }
    
    public let settingsManager: ServerSettingsManager
    public let status = CurrentValueSubject<ServerStatus, Error>(.disconnected)
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverSettings: DB_ServerSettings) {
        settingsManager = ServerSettingsManager(serverSettings: serverSettings)
    }
    
    public func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<Void, Error> {
        settingsManager.updateServerSettings(serverSettings)
    }
    
    public func deleteServer() -> AnyPublisher<Void, Error> {
        settingsManager.deleteServer()
    }
    
    static func create(_ settings: ServerSettings, inContext context: NSManagedObjectContext) -> AnyPublisher<ServerManager, Error> {
        let serverSettings = DB_ServerSettings(context: context)
        _ = settings.updateManaged(serverSettings)
        
        return context.savePublisher()
            .map { _ -> ServerManager in
                ServerManager(serverSettings: serverSettings)
            }
            .eraseToAnyPublisher()
    }
}
