//
//  APIResponseErrorMapper.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol APIResponseErrorMapper {
    func mapError(error: APIClientErrorWrapper, requestErrorMapper: Mappeable?) -> Error
}
