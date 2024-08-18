//
//  MoviesPresenter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MoviesPresenter {

    weak var view: MoviesViewProtocol?
    private let paginationService: PaginationService<Movie>
    
    internal var items: [Movie] = []
    
    init(interactor: MoviesInteractorProtocol) {
        self.paginationService = PaginationService { page in
            let queryParams = MoviesQueryParams(nowPlayingMovies: page)
            return try await interactor.getMovieList(queryParams: queryParams)
        }
    }
}

extension MoviesPresenter: MoviesPresenterProtocol {
    
    func updateMovieList() {
        Task {
            do {
                let newItems = try await paginationService.fetchNextPage()                
                await MainActor.run {
                    self.items.append(contentsOf: newItems)
                    self.view?.reloadData(items: self.items)
                }
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
}
