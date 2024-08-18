//
//  AsyncRepository.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

protocol AsyncRepository: AnyObject {
    func request<Response: Decodable>(
        request: APIRequest,
        responseType: Response.Type,
        retries: Int
    ) async throws -> Response
    
    func requestData(
        request: APIRequest,
        retries: Int
    ) async throws -> Data
    
    func emptyResponseRequest(
        request: APIRequest,
        retries: Int
    ) async throws
}
