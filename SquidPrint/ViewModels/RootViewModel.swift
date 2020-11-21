//
//  RootViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-21.
//

import Foundation
import SquidPrintLogic
import Combine

class RootViewModel: ObservableObject {
    let coreDataStorage: CoreDataStorage
    let serverManager: ServerManager
    
    let serverSettingsViewModel: ServerSettingsViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        coreDataStorage = serviceContainer.coreDataStorage
        serverManager = serviceContainer.serverManager
        serverSettingsViewModel = ServerSettingsViewModel(serverManager: serverManager)
    }
}
