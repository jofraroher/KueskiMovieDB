//
//  URLSessionAPIClient.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

final class URLSessionAPIClient: APIClient {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func processRequest(_ request: APIRequest, retries: Int) async -> Result<Data, APIClientErrorWrapper> {
        for _ in 0..<retries {
            switch await processRequest(request: request) {
            case .success(let data):
                return .success(data)
            case .failure:
                continue
            }
        }
        return await processRequest(request: request)
    }
    
    private func processRequest(request: APIRequest) async -> Result<Data, APIClientErrorWrapper> {
        guard let url = request.url else {
            return .failure(APIClientErrorWrapper(
                error: KueskiMovieRequestError.invalidURL,
                responseData: nil
            ))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        if let parameters = request.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return await withCheckedContinuation { continuation in
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(returning: .failure(APIClientErrorWrapper(
                        error: error,
                        responseData: data
                    )))
                } else if let data = data, let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode {
                    continuation.resume(returning: .success(data))
                } else {
                    continuation.resume(returning: .failure(APIClientErrorWrapper(
                        error: KueskiMovieRequestError.invalidResponse,
                        responseData: data
                    )))
                }
            }
            task.resume()
        }
    }
}
