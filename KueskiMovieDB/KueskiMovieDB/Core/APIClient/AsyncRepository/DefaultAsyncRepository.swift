//
//  DefaultAsyncRepository.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

final class DefaultAsyncRepository: AsyncRepository {
    
    private let apiClient: APIClient
    private let tokenProvider: AuthorizationTokenProvider?
    private let defaultErrorMapper: APIResponseErrorMapper
    
    init(
        client: APIClient,
        tokenProvider: AuthorizationTokenProvider?,
        defaultErrorMapper: APIResponseErrorMapper
    ) {
        self.apiClient = client
        self.tokenProvider = tokenProvider
        self.defaultErrorMapper = defaultErrorMapper
    }
    
    convenience init(tokenProvider: AuthorizationTokenProvider) {
        self.init(
            client: URLSessionAPIClient(),
            tokenProvider: tokenProvider,
            defaultErrorMapper: DefaultAPIClientErrorMapper()
        )
    }
    
    func request<Response: Decodable>(request: APIRequest, responseType: Response.Type, retries: Int) async throws -> Response {
        try await processRequestDependingOnType(request: request, responseType: responseType, retries: retries)
    }
    
    func requestData(request: APIRequest, retries: Int) async throws -> Data {
        try await processRequestDependingOnType(request: request, responseType: Data.self, retries: retries)
    }
    
    func emptyResponseRequest(request: APIRequest, retries: Int) async throws {
        _ = try await processRequestDependingOnType(request: request, responseType: Void.self, retries: retries)
    }
}

extension DefaultAsyncRepository {
    private func processRequestDependingOnType<Response>(
        request: APIRequest,
        responseType: Response.Type,
        retries: Int = 0
    ) async throws -> Response {
        if request.authorizationType == .none {
            return try await processRequest(
                request: request,
                responseType: responseType,
                retries: retries
            )
        } else {
            return try await authorizedRequest(
                request: request,
                responseType: responseType,
                retries: retries
            )
        }
    }
    
    private func authorizedRequest<Response>(
        request: APIRequest,
        responseType: Response.Type,
        retries: Int = 0
    ) async throws -> Response {
        guard let tokenProvider = tokenProvider else {
            throw KueskiMovieRequestError.missingAuthorizationToken
        }
        var mutableRequest = request
        let token = try await tokenProvider.authorizationToken()
        
        if mutableRequest.headers != nil {
            mutableRequest.headers?.merge(request.authorizationType.authorizationHeader(token: token), uniquingKeysWith: { current, _ in current })
        } else {
            mutableRequest.headers = request.authorizationType.authorizationHeader(token: token)
        }
        
        return try await processRequest(
            request: mutableRequest,
            responseType: responseType,
            retries: retries
        )
    }
    
    private func processRequest<Response>(
        request: APIRequest,
        responseType: Response.Type,
        retries: Int
    ) async throws -> Response {
        if responseType is Data.Type {
            guard let response = try await processRequestData(request: request, retries: retries) as? Response else {
                throw KueskiMovieRequestError.undefined
            }
            return response
        } else {
            return try await processRequestDecodable(
                request: request,
                responseType: responseType,
                retries: retries
            )
        }
    }
    
    private func processRequestDecodable<Response>(
        request: APIRequest,
        responseType: Response.Type,
        retries: Int
    ) async throws -> Response {
        switch await apiClient.processRequest(request, retries: retries) {
        case .success(let responseData):
            return try request.responseDecoder.decode(type: responseType, from: responseData)
        case .failure(let error):
            throw defaultErrorMapper.mapError(error: error, requestErrorMapper: request.errorMapper)
        }
    }
    
    private func processRequestData(
        request: APIRequest,
        retries: Int
    ) async throws -> Data {
        switch await apiClient.processRequest(request, retries: retries) {
        case .success(let responseData):
            return responseData
        case .failure(let error):
            throw defaultErrorMapper.mapError(error: error, requestErrorMapper: request.errorMapper)
        }
    }
}
