//
//  CoreDataExecutor.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine
import CoreData

public class CoreDataExecutor<T> {
    final func execute(inContext context: NSManagedObjectContext) -> AnyPublisher<T, Error> {
        doExecute(inContext: context)
    }
    
    func doExecute(inContext context: NSManagedObjectContext) -> AnyPublisher<T, Error> {
        Fail<T, Error>(error: GenericError.notImplemented)
            .eraseToAnyPublisher()
    }
}
