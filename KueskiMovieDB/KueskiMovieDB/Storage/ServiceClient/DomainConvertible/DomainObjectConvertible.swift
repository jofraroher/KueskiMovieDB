//
//  DomainObjectConvertible.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import CoreData

protocol DomainObjectConvertible {
    associatedtype DomainType
    func toDomainObject() -> DomainType
    static func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>
}
