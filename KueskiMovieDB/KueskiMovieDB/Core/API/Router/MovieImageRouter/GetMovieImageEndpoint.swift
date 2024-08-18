//
//  GetMovieImageEndpoint.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

struct GetMovieImageEndpoint: APIRequest {
    
    var url: URL? {
        URL(string: String.getConfigurationValue(
            key: MoviesBaseConfiguration.baseMovieImagePath,
            bundle: .KueskiMovieDB
        )
            + urlParams.imageSize.rawValue
            + urlParams.imagePath
        )
    }
    
    let method: HTTPRequestMethod = .get
    
    var parameters: [String : Any]?
    
    var encoding: HTTPParametersEncoding = .JSONEncoding()
    
    var headers: [String : String]?
    
    var errorMapper: (any Mappeable)?
    
    var responseDecoder: APIResponseDecoder = VoidableAPIResponseDecoder()
    
    var authorizationType: APIClientAuthorizationType = .none
    
    var urlParams: ImageQueryParamsProtocol
    
    init(urlParams: ImageQueryParamsProtocol) {
        self.urlParams = urlParams
    }
}
