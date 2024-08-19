//
//  StorableEntity.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import CoreData

protocol StorableDomainProtocol {
    associatedtype EntityType: DomainObjectConvertible
    func toEntity(context: NSManagedObjectContext) -> EntityType
}
