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

public class DefaultServerManager {
    private let settingsManager: CoreDataServerSettingsManager
    private var communicationManager: ServerCommunicationManager
    public private(set) var printerManager: PrinterManager
    public var status: CurrentValueSubject<ServerStatus, Never> { communicationManager.status }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverSettings: DB_ServerSettings) {
        settingsManager = CoreDataServerSettingsManager(serverSettings: serverSettings)
        communicationManager = ServerCommunicationManager(serverSettings: ServerSettings(managed: serverSettings))
        printerManager = DefaultPrinterManager(serverApiExecutor: communicationManager, serverStatus: communicationManager.status)
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

extension DefaultServerManager {
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
        printerManager = DefaultPrinterManager(serverApiExecutor: communicationManager, serverStatus: communicationManager.status)
    }
    
    public func move(withInstructions instructions: PrintheadInstructionSet) -> AnyPublisher<Void, Error> {
        fatalError()
    }
}

extension DefaultServerManager: ServerManager {
    public var id: Int { settings.id }
    public var name: String { settings.displayName }
    public var settings: ServerSettings { ServerSettings(managed: settingsManager.serverSettingsManaged.value) }
}
