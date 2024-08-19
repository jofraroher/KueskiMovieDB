//
//  PaginationServiceTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

struct TestItem: Equatable {
    let id: Int
}

final class PaginationServiceTests: XCTestCase {
    private var paginationService: PaginationService<TestItem>!
    private var fetchPageMock: (Int, SortByType) async throws -> [TestItem] = { _, _ in [] }

    override func setUp() {
        super.setUp()
        // Define la función mock para que devuelva un array de TestItem no opcional
        fetchPageMock = { page, sortBy in
            return [TestItem(id: page)] // Simula una lista de items con el id igual a la página
        }
        paginationService = PaginationService(fetchPage: fetchPageMock)
    }

    override func tearDown() {
        paginationService = nil
        super.tearDown()
    }

    func testFetchNextPage_returnsItems() async throws {
        // Act
        let items = try await paginationService.fetchNextPage()
        
        // Assert
        XCTAssertEqual(items as? [TestItem], [TestItem(id: 1)])
    }
    
    func testFetchNextPage_incrementsPage() async throws {
        // Act
        _ = try await paginationService.fetchNextPage()
        let items = try await paginationService.fetchNextPage()
        
        // Assert
        XCTAssertEqual(items as? [TestItem], [TestItem(id: 2)])
    }
    
    func testFetchBySort_resetsPageAndFetchesItems() async throws {
        // Arrange
        _ = try await paginationService.fetchNextPage()
        
        // Act
        let items = try await paginationService.fetchBySort(sortBy: .popularityDesc)
        
        // Assert
        XCTAssertEqual(items as? [TestItem], [TestItem(id: 1)])
    }
    
    func testReset_resetsPageAndSort() async throws {
        // Arrange
        _ = try await paginationService.fetchNextPage()
        paginationService.reset()
        
        // Act
        let items = try await paginationService.fetchNextPage()
        
        // Assert
        XCTAssertEqual(items as? [TestItem], [TestItem(id: 1)])
    }
}
