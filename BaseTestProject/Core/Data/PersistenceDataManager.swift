//
//  PersistenceDataManager.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import Foundation
import CoreData

class PersistenceDataManager {
    static let shared = PersistenceDataManager()
    static let modelName: String = "MesaDataModel"

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: PersistenceDataManager.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription,error) in
            if let error = error as NSError? {
                debugPrint("Error no CoreData: ", error)
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    func save() {
        let saveContext = persistentContainer.viewContext
        if saveContext.hasChanges {
            do {
                try saveContext.save()
            } catch {
                if let error = error as NSError? {
                   debugPrint("Error ao salvar contexto do CoreData: ", error)
                }
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do {
            let objects = try context.fetch(request)
            completion(objects)
        } catch {
            debugPrint("Error ao realizar fetch de data da classe \(type) : ", error)
            completion([])
        }
    }
    
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>, completion: @escaping ([T]) -> Void) {
        do {
            let objects = try context.fetch(request)
            completion(objects)
        } catch {
            debugPrint("Error ao realizar fetch de data no CoreData : ", error)
            completion([])
        }
    }
    
}
