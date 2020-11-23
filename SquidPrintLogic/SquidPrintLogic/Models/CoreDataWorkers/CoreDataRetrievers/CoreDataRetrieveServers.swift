//
//  CoreDataRetrieveServers.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import CoreData
import Combine

class CoreDataRetrieveServers: CoreDataAutoSaveExecutor<[ServerManager]> {
    
    override func doExecuteAndAutoSave(inContext context: NSManagedObjectContext) throws -> [ServerManager] {
        let request: NSFetchRequest<DB_ServerSettings> = DB_ServerSettings.fetchRequest()
        
        let result = try context.fetch(request)
        
        return result.map { settings in
            ServerManager(serverSettings: settings)
        }
    }
    
}
