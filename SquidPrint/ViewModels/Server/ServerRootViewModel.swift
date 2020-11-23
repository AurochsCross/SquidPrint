//
//  ServerRootViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class ServerRootViewModel: ObservableObject {
    let serverManager: ServerManager
    let dashboardViewModel: DashboardViewModel
    let settingsViewModel: SettingsViewModel
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
        self.dashboardViewModel = DashboardViewModel(serverManager: serverManager)
        self.settingsViewModel = SettingsViewModel(serverManager: serverManager)
    }
}
