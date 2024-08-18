//
//  APIResponseDecoder.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

protocol APIResponseDecoder {
    func decode<T>(type: T.Type, from data: Data) throws -> T
}
