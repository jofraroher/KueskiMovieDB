//
//  MoviesProtocols.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

protocol MoviesRouterProtocol: AnyObject {
    func navigateToMovieDetail(model: Movie)
}

protocol MoviesViewProtocol: UIViewController {
    @MainActor func reloadData(items: [Movie])
    func showAlert()
}

protocol MoviesPresenterProtocol: AnyObject {
    var items: [Movie] { get }
    
    func updateMovieList()
    func updateMovieListBySort(sortBy: SortByType)
    func navigateToMovieDetail(model: Movie)
    func refreshStatu()
}

protocol MoviesNetworkProtocol: AnyObject {
    func getMovieList(queryParams: MoviesQueryParams) async throws -> [Movie]
}

protocol MoviesFetchingProtocol: AnyObject {
    func getSavedMovies() async throws -> [Movie]
}

protocol MoviesDatabaseProtocol: AnyObject {
    func saveMovie(model: Movie) async throws
    func deleteMovie(model: Movie) async throws
}

protocol CellConfigurator: AnyObject {
    func configureCell(_ cell: UICollectionViewCell, with item: Movie)
}

protocol LayoutProvider {
    func createLayout() -> UICollectionViewLayout
}
