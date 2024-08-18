//
//  PaginationService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol PaginationServiceProtocol {
    associatedtype Item
    func fetchNextPage() async throws -> [Item]
    func fetchBySort(sortBy: SortByType) async throws -> [Item]
    func reset()
}

final class PaginationService<Item>: PaginationServiceProtocol {
    
    private var currentPage = 1
    private var currentSort = SortByType.popularityDesc
    private let fetchPage: (Int, SortByType) async throws -> [Item]
    
    init(fetchPage: @escaping (Int, SortByType) async throws -> [Item]) {
        self.fetchPage = fetchPage
    }
    
    func fetchNextPage() async throws -> [Item] {
        let items = try await fetchPage(currentPage, currentSort)
        currentPage += 1
        return items
    }
    
    func fetchBySort(sortBy: SortByType) async throws -> [Item] {
        currentSort = sortBy
        currentPage = 1
        return try await fetchNextPage()
    }
    
    func reset() {
        currentPage = 1
        currentSort = .popularityDesc
    }
}
