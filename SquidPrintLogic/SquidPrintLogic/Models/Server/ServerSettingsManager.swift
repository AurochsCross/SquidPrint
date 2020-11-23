//
//  ServerSettingsManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import CoreData

public class ServerSettingsManager {
    let serverSettingsManaged: CurrentValueSubject<DB_ServerSettings, Error>
    private let context: NSManagedObjectContext
    
    public let serverSettingsPublisher: AnyPublisher<ServerSettings, Error>
    
    private var cancellables = Set<AnyCancellable>()
    
    internal init(serverSettings: DB_ServerSettings) {
        serverSettingsManaged = CurrentValueSubject(serverSettings)
        context = serverSettings.managedObjectContext!
        
        serverSettingsPublisher = serverSettingsManaged
            .map { ServerSettings(managed: $0) }
            .eraseToAnyPublisher()
    }
    
    func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<Void, Error> {
        serverSettingsManaged.value = serverSettings.updateManaged(serverSettingsManaged.value)
        return serverSettingsManaged.value.managedObjectContext!.savePublisher()
    }
    
    func deleteServer() -> AnyPublisher<Void, Error> {
        context.delete(serverSettingsManaged.value)
        return context.savePublisher()
    }
}
