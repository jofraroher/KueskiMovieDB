//
//  APIRequest.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

protocol APIRequest {
    var url: URL? { get }
    var method: HTTPRequestMethod { get }
    var parameters: [String: Any]? { get }
    var encoding: HTTPParametersEncoding { get }
    var headers: [String: String]? { get set }
    var errorMapper: Mappeable? { get }
    var responseDecoder: APIResponseDecoder { get }
    var authorizationType: APIClientAuthorizationType { get }
}
