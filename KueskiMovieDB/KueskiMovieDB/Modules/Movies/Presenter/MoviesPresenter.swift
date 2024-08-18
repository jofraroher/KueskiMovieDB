//
//  MoviesPresenter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MoviesPresenter {
    
    weak var view: MoviesViewProtocol?
    private let interactor: MoviesInteractorProtocol
    
    private var currentPage = 1
    
    internal var items: [Movie] = []
    
    init(interactor: MoviesInteractorProtocol) {
        self.interactor = interactor
    }
}

extension MoviesPresenter: MoviesPresenterProtocol {
    
    func updateMovieList() {
        Task { await fetchMovies() }
    }
}

extension MoviesPresenter {
    private func fetchMovies() async {
        do {
            let response = try await interactor.getMovieList(queryParams: MoviesQueryParams(nowPlayingMovies: currentPage))
            items.append(contentsOf: response)
            currentPage += 1
            await view?.reloadData(items: items)
        } catch {
            print(error)
        }
    }
}
