//
//  ConfigurationConstantsKey.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol ConfigurationConstantsKeyProtocol {
    var constantKey: String { get }
}

enum MoviesBaseConfiguration: String, ConfigurationConstantsKeyProtocol {
    
    case baseMovieDBPath = "BASE_KUESKI_MOVIEDB_PATH"
    case baseMovieImagePath = "BASE_MOVIE_IMAGE_PATH"
    
    var constantKey: String {
        self.rawValue
    }
}
