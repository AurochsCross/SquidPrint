//
//  ServersManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine

public class ServersManager {
    public let servers = CurrentValueSubject<[ServerManager], Error>([])
    
    private let storage: CoreDataStorage
    private var cancellables = Set<AnyCancellable>()
    
    public init(coreDataStorage: CoreDataStorage) {
        self.storage = coreDataStorage
        loadServers()
    }
    
    public func loadServers() {
        storage.context.execute(worker: CoreDataRetrieveServers())
            .catch { error -> Just<[ServerManager]> in
                log.error(error)
                return Just<[ServerManager]>([])
            }
            .assign(to: \.servers.value, on: self)
            .store(in: &cancellables)
    }
    
    public func addServer(serverSettings: ServerSettings) -> AnyPublisher<ServerManager, Error> {
        DefaultServerManager.create(serverSettings, inContext: storage.context)
            .map { server in
                self.servers.value = self.servers.value + [server]
                return server
            }
            .eraseToAnyPublisher()
    }
    
    
}
