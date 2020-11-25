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
    var serversManager: ServersManager { get }
}

class DefaultServiceContainer: ServiceContainer {
    private let defaultCoreDataStorage: CoreDataStorage
    private let defaultServersManager: ServersManager
    
    init() {
        defaultCoreDataStorage = CoreDataStorage()
        defaultServersManager = ServersManager(coreDataStorage: defaultCoreDataStorage)
    }
    
    var coreDataStorage: CoreDataStorage { defaultCoreDataStorage }
    var serversManager: ServersManager { defaultServersManager }
}
