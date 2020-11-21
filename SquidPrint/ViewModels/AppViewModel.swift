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
    
    let serverSettingsViewModel: ServerSettingsViewModel
    
    @Published var appLoaded = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        coreDataStorage = CoreDataStorage()
        serverManager = ServerManager(coreDataStorage: coreDataStorage)
        serverSettingsViewModel = ServerSettingsViewModel(serverManager: serverManager)
        
        coreDataStorage.initStorage()
            .map { none -> Bool in
                return true
            }
            .catch { error -> Just<Bool> in
                return Just(false)
            }
            .assign(to: \.appLoaded, on: self)
            .store(in: &cancellables)
    }
}
