//
//  CoreDataRetrieveServerSettings.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

class CoreDataRetrieveServerSettings: CoreDataAutoSaveExecutor<DB_ServerSettings?> {
    
    override func doExecuteAndAutoSave(inContext context: NSManagedObjectContext) throws -> DB_ServerSettings? {
        let request: NSFetchRequest<DB_ServerSettings> = DB_ServerSettings.fetchRequest()
        
        let result = try context.fetch(request)
        
        return result.first
    }
    
}
