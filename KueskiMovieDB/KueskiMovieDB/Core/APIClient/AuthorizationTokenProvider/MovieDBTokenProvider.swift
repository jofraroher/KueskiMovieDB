//
//  MovieDBTokenProvider.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MovieDBTokenProvider: AuthorizationTokenProvider {

    func authorizationToken() async throws -> String {
        return String.getConfigurationValue(
            key: MoviesBaseConfiguration.baseAuthenticationKey,
            bundle: .KueskiAPI
        )
    }
}
