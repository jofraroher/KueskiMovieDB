//
//  DefaultAPIClientErrorMapper.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

struct DefaultAPIClientErrorMapper: APIResponseErrorMapper {
    
    func mapError(error: APIClientErrorWrapper, requestErrorMapper: Mappeable?) -> Error {
        guard let errorMapper = requestErrorMapper,
              let responseData = error.responseData else {
            return error.error
        }
        
        if let movieDBError: KueskiMovieDBError = errorMapper.map(responseData) {
            return movieDBError
        } else if let error: Error = errorMapper.map(responseData) {
            return error
        } else {
            return error.error
        }
    }
}
