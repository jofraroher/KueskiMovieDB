//
//  AuthorizationTokenProvder.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol AuthorizationTokenProvider {
    func authorizationToken() async throws -> String
}
