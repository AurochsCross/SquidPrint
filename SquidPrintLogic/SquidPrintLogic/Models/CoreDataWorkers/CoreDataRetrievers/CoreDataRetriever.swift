//
//  CoreDataRetriever.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

class CoreDataRetriever<T>: CoreDataExecutor<T> {
    final func retrieveData(fromContext context: NSManagedObjectContext) -> AnyPublisher<T, Error> {
        doRetrieveData(fromContext: context)
    }
    
    func doRetrieveData(fromContext context: NSManagedObjectContext) -> AnyPublisher<T, Error> {
        Fail<T, Error>(error: GenericError.notImplemented)
            .eraseToAnyPublisher()
    }
    
    override func doExecute(inContext context: NSManagedObjectContext) -> AnyPublisher<T, Error> {
        retrieveData(fromContext: context)
    }
}
