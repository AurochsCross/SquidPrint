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
    private var serverSettingsManaged: DB_ServerSettings? = nil
    
    public let isSetupSubject = CurrentValueSubject<Bool, Error>(false)
    
    public var serverSettingsPublisher: AnyPublisher<ServerSettings, Error> {
        return self.coreDataStorage.execute(worker: CoreDataRetrieveServerSettings())
            .map { managed -> ServerSettings in
                self.serverSettingsManaged = managed
                
                if let managed = managed {
                    self.isSetupSubject.value = true
                    return ServerSettings(managed: managed)
                }
                
                self.isSetupSubject.value = false
                return ServerSettings()
            }
            .eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
        
        coreDataStorage.isStorageLoaded
            .sink(receiveCompletion: { _ in }) { _ in
                self.serverSettingsPublisher
                    .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
                    .store(in: &self.cancellables)
            }
            .store(in: &cancellables)
    }
    
    public func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<Void, Error> {
        
        let settings = serverSettings.updateManaged(serverSettingsManaged, context: coreDataStorage.context)
//        if let server = 
        
        return coreDataStorage.save()
            .map { _ -> Void in
                if !self.isSetupSubject.value {
                    self.isSetupSubject.value = true
                }
                return
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteServer() {
        coreDataStorage.deleteEntities(ofType: DB_ServerSettings.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print("Error deleting server: \(error)")
                case .finished:
                    self.serverSettingsManaged = nil
                    self.isSetupSubject.value = false
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
