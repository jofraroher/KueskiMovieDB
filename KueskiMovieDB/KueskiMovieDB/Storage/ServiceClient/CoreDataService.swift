//
//  CoreDataService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import CoreData

final class CoreDataService: DatabaseServiceProtocol {
    
    let context: NSManagedObjectContext
    
    init() {
        context = CoreDataStack.shared.mainContext
    }
    
    func saveData<T: StorableDomainProtocol>(_ data: T, for request: String) async throws {
        let _ = data.toEntity(context: context)
        
        do {
            try await context.perform {
                try self.context.save()
            }
        } catch {
            throw KueskiMovieDatabaseError.saveFailed(error)
        }
    }
    
    func fetchData<T: DomainObjectConvertible>(for request: String, type: T.Type) async throws -> [T.DomainType] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        
        do {
            let results = try await context.perform {
                try self.context.fetch(fetchRequest)
            }
            
            let domainObjects: [T.DomainType] = results.compactMap {
                guard let entity = $0 as? T else {
                    return nil
                }
                return entity.toDomainObject()
            }
            
            return domainObjects
        } catch {
            throw KueskiMovieDatabaseError.fetchFailed(error)
        }
    }
    
    func deleteData(for request: String) async throws {        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: MovieEntity.description())
        fetchRequest.predicate = NSPredicate(format: "id == %@", request)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            let _ = try await context.perform {
                try self.context.execute(batchDeleteRequest) as? NSBatchDeleteResult
            }
        } catch {
            throw KueskiMovieDatabaseError.deleteFailed(error)
        }
    }
}
