//
//  CoreDataAutoSaveExecutor.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

class CoreDataAutoSaveExecutor<T>: CoreDataExecutor<T> {
    final override func doExecute(inContext context: NSManagedObjectContext) -> AnyPublisher<T, Error> {
        
        return Future<T, Error> { promise in
            do {
                let result = try self.doExecuteAndAutoSave(inContext: context)
                try context.save()
                promise(.success(result))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func doExecuteAndAutoSave(inContext context: NSManagedObjectContext) throws -> T {
        fatalError("Not implemented")
    }
}
