//
//  VoidableAPIResponseDecoder.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

final class VoidableAPIResponseDecoder: APIResponseDecoder {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    convenience init() {
        self.init(decoder: JSONDecoder())
    }
    
    func decode<T>(type: T.Type, from data: Data) throws -> T {
        if type.self == Void.self, let result = () as? T {
            return result
        } else if let decodableType = type as? Decodable.Type,
                  let decodedObject = try decodableType.init(data: data, decoder: decoder) as? T {
            return decodedObject
        }
        throw KueskiMovieRequestError.undefined
    }
}
