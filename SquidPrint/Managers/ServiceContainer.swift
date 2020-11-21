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
}

class DefaultServiceContainer: ServiceContainer {
    private let defaultCoreDataStorage = CoreDataStorage()
    var coreDataStorage: CoreDataStorage { defaultCoreDataStorage }
}
