//
//  StorableEntityProtocol.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import CoreData

protocol StorableEntityProtocol {
    func populateEntity(from domainObject: Any, context: NSManagedObjectContext) throws
}
