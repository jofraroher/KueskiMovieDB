//
//  GetPopularMoviesEndpoint.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import Foundation

struct GetPopularMoviesEndpoint: APIRequest {
    
    var url: URL? {
        var urlComponents = URLComponents(string: String.getConfigurationValue(
            key: MoviesBaseConfiguration.baseMovieDBPath,
            bundle: .KueskiMovieDB
        ))
        urlComponents?.queryItems = queryParams.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        return urlComponents?.url
    }
    
    let method: HTTPRequestMethod = .get
    
    var parameters: [String : Any]?
    
    var encoding: HTTPParametersEncoding = .JSONEncoding()
    
    var headers: [String : String]?
    
    var errorMapper: (any Mappeable)?
    
    var responseDecoder: APIResponseDecoder = VoidableAPIResponseDecoder()
    
    var authorizationType: APIClientAuthorizationType = .bearerToken
    
    var queryParams: [String: Any]
    
    init(queryParams: [String : Any]) {
        self.queryParams = queryParams
    }
}
