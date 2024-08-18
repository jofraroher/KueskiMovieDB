//
//  HTTPParametersEncoding.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

enum HTTPParametersEncoding: Equatable {
    case JSONEncoding(type: JsonEncodingType = .default)
    case URLEncoding(type: URLEncodingType = .default)
}

enum JsonEncodingType: Equatable {
    case prettyPrinted
    case `default`
}

enum URLEncodingType: Equatable {
    case `default`
    case queryString
    case httpBody
}
