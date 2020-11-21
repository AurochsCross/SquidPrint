//
//  AppViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-19.
//

import Foundation
import SquidPrintLogic
import Combine

class AppViewModel: ObservableObject {
    let coreDataStorage: CoreDataStorage
    let serverManager: ServerManager
    
    let rootViewModel: RootViewModel
    let serverSettingsViewModel: ServerSettingsViewModel
    
    @Published var appLoaded = false
    @Published var isServerSetup = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        coreDataStorage = serviceContainer.coreDataStorage
        serverManager = serviceContainer.serverManager
        rootViewModel = RootViewModel()
        serverSettingsViewModel = ServerSettingsViewModel(serverManager: serverManager)
        
//        coreDataStorage.isStorageLoaded
//            .dropFirst()
//            .flatMap { loaded -> AnyPublisher<Bool, Error> in
//                if loaded {
//                    return self.serverManager.isSetupSubject.eraseToAnyPublisher()
//                } else {
//                    return Fail<Bool, Error>(error: GenericError.unknown).eraseToAnyPublisher()
//                }
//            }
//            .catch { error -> Just<Bool> in
//                return Just(false)
//            }
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.isServerSetup, on: self)
//            .store(in: &cancellables)
        
        serverManager.isSetupSubject
//            .dropFirst()
            .catch { error -> Just<Bool> in
                return Just(false)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isServerSetup, on: self)
            .store(in: &cancellables)
        
        $isServerSetup
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.appLoaded = true
            }
            .store(in: &cancellables)
        
        
    }
}
