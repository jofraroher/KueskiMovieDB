//
//  MockURLSessionDataTask.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import Foundation

final class MockURLSessionDataTask: URLSessionDataTask {
    private let resumeHandler: (() -> Void)?
    
    init(resumeHandler: (() -> Void)? = nil) {
        self.resumeHandler = resumeHandler
    }
    
    override func resume() {
        resumeHandler?()
    }
}
