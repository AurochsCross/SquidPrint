//
//  DashboardViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class DashboardViewModel: ObservableObject {
    @Published var name: String
    
    let serverManager: ServerManager
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
        self.name = serverManager.name
    }
}
