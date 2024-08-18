//
//  PaginationService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol PaginationServiceProtocol {
    associatedtype Item
    func fetchNextPage() async throws -> [Item]
    func reset()
}

final class PaginationService<Item>: PaginationServiceProtocol {
    
    private var currentPage = 1
    private let fetchPage: (Int) async throws -> [Item]
    
    init(fetchPage: @escaping (Int) async throws -> [Item]) {
        self.fetchPage = fetchPage
    }
    
    func fetchNextPage() async throws -> [Item] {
        let items = try await fetchPage(currentPage)
        currentPage += 1
        return items
    }
    
    func reset() {
        currentPage = 1
    }
}
