//
//  ServiceContainer.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import SquidPrintLogic

protocol ServiceContainer {
    var coreDataStorage: CoreDataStorage { get }
    var serverManager: ServerManager { get }
}

class DefaultServiceContainer: ServiceContainer {
    private let defaultCoreDataStorage: CoreDataStorage
    private let defaultServerManager: ServerManager
    
    init() {
        defaultCoreDataStorage = CoreDataStorage()
        defaultServerManager = ServerManager(coreDataStorage: defaultCoreDataStorage)
    }
    
    var coreDataStorage: CoreDataStorage { defaultCoreDataStorage }
    var serverManager: ServerManager { defaultServerManager }
}
