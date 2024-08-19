//
//  DependencyContainer.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import CoreData

final class DependencyContainer: DependencyContainerProtocol {
    static let shared = DependencyContainer()

    private init() { }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "KueskiMovieDB")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var databaseService: DatabaseServiceProtocol {
        return CoreDataService(context: persistentContainer.viewContext)
    }
}
