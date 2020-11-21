//
//  ServerManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine

public class ServerManager {
    private let coreDataStorage: CoreDataStorage
    public var serverSettingsPublisher: AnyPublisher<ServerSettings, Error> { coreDataStorage.execute(worker: CoreDataRetrieveServerSettings()) }
    
    public init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    public func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<ServerSettings, Error> {
        coreDataStorage.execute(worker: CoreDataWriteServerSettings(serverSettings))
    }
}
