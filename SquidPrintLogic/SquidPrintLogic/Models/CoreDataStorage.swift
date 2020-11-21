//
//  CoreDataStorage.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import CoreData
import Combine

public class CoreDataStorage {
    var storageLoadedPublisher = PassthroughSubject<Bool, Error>()
    let persistentContainer: NSPersistentContainer
    
    
    public init() {
        let bundle = Bundle(identifier: "com.AurochsCross.SquidPrintLogic")
        
        let modelUrl = bundle!.url(forResource: "SquidPrintDataModel", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl!)
        persistentContainer = NSPersistentContainer(name: "SquidPrintDataModel", managedObjectModel: managedObjectModel!)
    }
    
    public func initStorage() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            self.persistentContainer.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func execute<T>(worker: CoreDataExecutor<T>) -> AnyPublisher<T, Error> {
        worker.execute(inContext: persistentContainer.viewContext)
    }
    
    func execute(worker: CoreDataExecutor<Bool>) -> AnyPublisher<Bool, Error> {
        worker.execute(inContext: persistentContainer.viewContext)
    }
}
