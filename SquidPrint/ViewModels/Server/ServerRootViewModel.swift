//
//  ServerRootViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic
import OpenAPIClient

class ServerRootViewModel: ObservableObject {
    let serverManager: ServerManager
    let dashboardViewModel: DashboardViewModel
    let settingsViewModel: SettingsViewModel
    let movementViewModel: MovementControlViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
        self.dashboardViewModel = DashboardViewModel(serverManager: serverManager)
        self.settingsViewModel = SettingsViewModel(serverManager: serverManager)
        self.movementViewModel = MovementControlViewModel(serverManager: serverManager)
        serverManager.connect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: return
                case .failure(let error): log.error(error)
                }
                
            }) { record in
                log.info("Connection to \(record.name ?? "-") established")
            }
            .store(in: &cancellables)
    }
}
