//
//  Decodable+Ext.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

extension Decodable {
    init(data: Data, decoder: JSONDecoder) throws {
        self = try decoder.decode(Self.self, from: data)
    }
}
