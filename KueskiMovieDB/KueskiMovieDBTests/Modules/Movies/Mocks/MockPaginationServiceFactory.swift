//
//  MockPaginationServiceFactory.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

final class MockPaginationServiceFactory: PaginationServiceFactoryProtocol {
    var paginationServiceToReturn: PaginationServiceProtocol?
    var makePaginationServiceCalled = false
    
    func makePaginationService(interactor: MoviesNetworkProtocol) -> PaginationServiceProtocol {
        makePaginationServiceCalled = true
        return paginationServiceToReturn!
    }
}
