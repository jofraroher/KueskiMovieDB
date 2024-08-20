//
//  APIRequestStub.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB
import Foundation

enum APIRequestStub {
    static func getAPIRquest(
        url: URL? = nil,
        method: HTTPRequestMethod = .get,
        authorizationType: APIClientAuthorizationType = .bearerToken,
        headers: [String: String]? = nil,
        parameters: [String : Any]? = nil
    ) -> APIRequest {
        APIRequestMock(
            url: url,
            method: method,
            parameters: parameters,
            encoding: .JSONEncoding(),
            headers: headers,
            responseDecoder: VoidableAPIResponseDecoder(),
            authorizationType: authorizationType
        )
    }
}

struct APIRequestMock: APIRequest {
    var url: URL?
    
    var method: HTTPRequestMethod
    
    var parameters: [String : Any]?
    
    var encoding: HTTPParametersEncoding
    
    var headers: [String : String]?
    
    var errorMapper: Mappeable?
    
    var responseDecoder: APIResponseDecoder
    
    var authorizationType: APIClientAuthorizationType
}
