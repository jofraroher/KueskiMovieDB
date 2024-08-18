//
//  MappeableType.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

protocol Mappeable {
    func map<T>(_ data: Data) -> T?
}
