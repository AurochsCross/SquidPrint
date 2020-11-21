//
//  CoreDataRetrieveServerSettings.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

class CoreDataRetrieveServerSettings: CoreDataAutoSaveExecutor<ServerSettings> {
    
    override func doExecuteAndAutoSave(inContext context: NSManagedObjectContext) throws -> ServerSettings {
        let request: NSFetchRequest<ServerSettings> = ServerSettings.fetchRequest()
        
        let result = try context.fetch(request)
        
        return result.first ?? ServerSettings(context: context)
    }
    
}
