//
//  APIClientErrorWrapper.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

struct APIClientErrorWrapper: Error {
    
    let error: Error
    let responseData: Data?
    
    init(error: Error, responseData: Data?) {
        self.error = error
        self.responseData = responseData
    }
}
