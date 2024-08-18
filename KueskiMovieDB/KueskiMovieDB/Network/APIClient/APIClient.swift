//
//  APIClient.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

protocol APIClient {
    func processRequest(_ request: APIRequest, retries: Int) async -> Result<Data, APIClientErrorWrapper>
}
