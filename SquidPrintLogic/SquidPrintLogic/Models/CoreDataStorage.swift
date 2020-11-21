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
    public let isStorageLoaded = CurrentValueSubject<Bool, Error>(false)
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    
    public init() {
        let bundle = Bundle(identifier: "com.AurochsCross.SquidPrintLogic")
        
        let modelUrl = bundle!.url(forResource: "SquidPrintDataModel", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl!)
        persistentContainer = NSPersistentContainer(name: "SquidPrintDataModel", managedObjectModel: managedObjectModel!)
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                self.isStorageLoaded.send(completion: .failure(error))
            } else {
                self.isStorageLoaded.value = true
            }
        }
    }
    func execute<T>(worker: CoreDataExecutor<T>) -> AnyPublisher<T, Error> {
        worker.execute(inContext: persistentContainer.viewContext)
    }
    
    func execute(worker: CoreDataExecutor<Bool>) -> AnyPublisher<Bool, Error> {
        worker.execute(inContext: persistentContainer.viewContext)
    }
    
    func save() -> AnyPublisher<Void, Error> {
        do {
            try self.persistentContainer.viewContext.save()
            return Just<Void>(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        } catch {
            return Fail<Void, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func discard() {
        self.persistentContainer.viewContext.reset()
    }
    
    func deleteEntities<T: NSManagedObject>(ofType type: T.Type) -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = type.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try self.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: self.persistentContainer.viewContext)
                try self.persistentContainer.viewContext.save()
                promise(.success(()))
            } catch let error as NSError {
                promise(.failure(error))
            }
        }
    }
}
