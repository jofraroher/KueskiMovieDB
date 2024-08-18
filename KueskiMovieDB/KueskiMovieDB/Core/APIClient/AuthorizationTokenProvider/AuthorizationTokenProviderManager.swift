//
//  AuthorizationTokenProviderManager.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

enum AuthorizationTokenProviderManager {
    
    static func getTokenAuthorization() -> AuthorizationTokenProvider {
        MovieDBTokenProvider()
    }
}
