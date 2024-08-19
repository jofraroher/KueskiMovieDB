//
//  MockPaginationService.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

final class MockPaginationService: PaginationServiceProtocol {
    var fetchNextPageCalled = false
    var fetchBySortCalled = false
    var fetchNextPageResult: [Any] = []
    var fetchBySortResult: [Any] = []
    var fetchNextPageError: Error?
    var fetchBySortError: Error?
    
    func fetchNextPage() async throws -> [Any] {
        fetchNextPageCalled = true
        if let error = fetchNextPageError {
            throw error
        }
        return fetchNextPageResult
    }

    func fetchBySort(sortBy: SortByType) async throws -> [Any] {
        fetchBySortCalled = true
        if let error = fetchBySortError {
            throw error
        }
        return fetchBySortResult
    }

    func reset() {
        // Implement if needed
    }
}
