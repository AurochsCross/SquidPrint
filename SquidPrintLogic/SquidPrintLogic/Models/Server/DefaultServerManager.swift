//
//  ServerManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData
import OpenAPIClient

public class DefaultServerManager: ServerManager {
    public var id: Int { settings.id }
    public var name: String { settings.displayName }
    public var settings: ServerSettings { ServerSettings(managed: settingsManager.serverSettingsManaged.value) }
    
    private let settingsManager: CoreDataServerSettingsManager
    private var communicationManager: ServerCommunicationManager
    public let status = CurrentValueSubject<ServerStatus, Never>(.disconnected)
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverSettings: DB_ServerSettings) {
        settingsManager = CoreDataServerSettingsManager(serverSettings: serverSettings)
        communicationManager = ServerCommunicationManager(serverSettings: ServerSettings(managed: serverSettings))
        updateCommunicationManager(withSettings: ServerSettings(managed: serverSettings))
    }
    
    public func connect() -> AnyPublisher<UserRecord, Error> {
        communicationManager.connect()
    }
    
    public func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<ServerSettings, Error> {
        settingsManager.updateServerSettings(serverSettings)
            .map { _ in
                self.communicationManager = ServerCommunicationManager(serverSettings: serverSettings)
                return serverSettings
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteServer() -> AnyPublisher<Void, Error> {
        settingsManager.deleteServer()
    }
    
    func updateCommunicationManager(withSettings settings: ServerSettings) {
        communicationManager = ServerCommunicationManager(serverSettings: settings)
        
        communicationManager.isConnected
            .map { isConnected -> ServerStatus in
                isConnected ? .connected : .disconnected
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.status.value, on: self)
            .store(in: &cancellables)
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
