//
//  StorableEntity.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import CoreData

protocol IdentifiableEntity {
    var idDomain: String { get }
}

protocol StorableDomainProtocol: IdentifiableEntity {
    associatedtype EntityType: NSManagedObject
    func toEntity(context: NSManagedObjectContext) -> EntityType
}
