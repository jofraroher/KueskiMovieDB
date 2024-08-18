//
//  APIClientAuthorizationType.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

enum APIClientAuthorizationType {
    case bearerToken
    case authorization
    case none
    
    func authorizationHeader(token: String) -> [String: String] {
        switch self {
        case .bearerToken:
            return ["Authorization": "Bearer \(token)"]
        case .authorization:
            return ["Authorization": token]
        case .none:
            return [:]
        }
    }
}
