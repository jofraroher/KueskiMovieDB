//
//  MoviesPresenter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MoviesPresenter {

    weak var view: MoviesViewProtocol?
    var router: MoviesRouterProtocol?
    internal let movieStorageService: MovieStorageServiceProtocol
    internal let syncService: MovieSyncServiceProtocol
    internal let paginationService: any PaginationServiceProtocol
    internal var items: [Movie] = []

    init(
        interactor: MoviesNetworkProtocol,
        movieStorageService: MovieStorageServiceProtocol,
        paginationServiceFactory: PaginationServiceFactoryProtocol,
        syncService: MovieSyncServiceProtocol
    ) {
        self.movieStorageService = movieStorageService
        self.syncService = syncService
        self.paginationService = paginationServiceFactory.makePaginationService(interactor: interactor)
    }
}

// MARK: - MoviesPresenterProtocol

extension MoviesPresenter: MoviesPresenterProtocol {

    func updateMovieList() {
        Task {
            do {
                let newItems = try await paginationService.fetchNextPage()
                guard let newItems = newItems as? [Movie] else {
                    throw KueskiMovieRequestError.invalidResponse
                }
                let updatedItems = try await syncService.syncWithSavedMovies(newItems: newItems, storageService: movieStorageService)
                await updateUI(with: updatedItems, append: true)
            } catch {
                await updateUI(with: items, append: false)
                await handleError(error)
            }
        }
    }

    func updateMovieListBySort(sortBy: SortByType) {
        Task {
            do {
                let newItems = try await paginationService.fetchBySort(sortBy: sortBy)
                guard let newItems = newItems as? [Movie] else {
                    throw KueskiMovieRequestError.invalidResponse
                }
                let updatedItems = try await syncService.syncWithSavedMovies(newItems: newItems, storageService: movieStorageService)
                await updateUI(with: updatedItems, append: false)
            } catch {
                await updateUI(with: items, append: false)
                await handleError(error)
            }
        }
    }

    func saveMovie(model: Movie) {
        Task {
            do {
                if model.isFavorite {
                    try await movieStorageService.deleteMovie(model: model)
                    await updateMovieStatus(with: model.id, isFavorite: false)
                } else {
                    try await movieStorageService.saveMovie(model: model)
                    await updateMovieStatus(with: model.id, isFavorite: true)
                }
            } catch {
                await updateUI(with: items, append: false)
                await handleError(error)
            }
        }
    }
    
    func refreshStatu() {
        Task {
            do {
                let refreshItems = try await syncService.syncWithSavedMovies(newItems: items, storageService: movieStorageService)
                await updateUI(with: refreshItems, append: false)
            } catch {
                await handleError(error)
            }
        }
    }
    
    func navigateToMovieDetail(model: Movie) {
        router?.navigateToMovieDetail(model: model)
    }
}

// MARK: - Private Methods

private extension MoviesPresenter {

    @MainActor
    func updateUI(with newItems: [Movie], append: Bool) {
        if append {
            items.append(contentsOf: newItems)
        } else {
            items = newItems
        }
        view?.reloadData(items: items)
    }

    @MainActor
    func updateMovieStatus(with id: Int, isFavorite: Bool) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].isFavorite = isFavorite
            view?.reloadData(items: items)
        }
    }

    @MainActor
    func handleError(_ error: Error) {
        view?.showAlert()
    }
}
