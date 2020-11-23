//
//  Context+Utilities.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import CoreData
import Combine

extension NSManagedObjectContext {
    func savePublisher() -> AnyPublisher<Void, Error> {
        do {
            try save()
            return Just<Void>(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        } catch {
            return Fail<Void, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func execute<T>(worker: CoreDataExecutor<T>) -> AnyPublisher<T, Error> {
        worker.execute(inContext: self)
    }
    
    func execute(worker: CoreDataExecutor<Bool>) -> AnyPublisher<Bool, Error> {
        worker.execute(inContext: self)
    }
}
