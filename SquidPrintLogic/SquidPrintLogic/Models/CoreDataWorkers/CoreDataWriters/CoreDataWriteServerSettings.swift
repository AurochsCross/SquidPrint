//
//  CoreDataWriteServerSettings.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

class CoreDataWriteServerSettings: CoreDataAutoSaveExecutor<ServerSettings> {
    private let serverSettings: ServerSettings
    
    init(_ settings: ServerSettings) {
        self.serverSettings = settings
    }
    
    override func doExecuteAndAutoSave(inContext context: NSManagedObjectContext) throws -> ServerSettings {
//        context.insert(serverSettings)
        return serverSettings
    }
}
