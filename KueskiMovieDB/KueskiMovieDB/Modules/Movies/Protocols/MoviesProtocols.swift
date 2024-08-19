//
//  MoviesProtocols.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

protocol MoviesViewProtocol: UIViewController {
    @MainActor func reloadData(items: [Movie])
}

protocol MoviesPresenterProtocol: AnyObject {
    var items: [Movie] { get }
    
    func updateMovieList()
    func updateMovieListBySort(sortBy: SortByType)
    func saveMovie(model: Movie)
}

protocol MoviesInteractorProtocol: AnyObject {
    func getMovieList(queryParams: MoviesQueryParams) async throws -> [Movie]
    func saveMovie(model: Movie) async throws
    func getSavedMovies() async throws -> [Movie]
    func deleteMovie(model: Movie) async throws
}

protocol CellConfigurator: AnyObject {
    func configureCell(_ cell: UICollectionViewCell, with item: Movie, and delegate: GenericCollectionViewCellDelegate?)
}

protocol LayoutProvider {
    func createLayout() -> UICollectionViewLayout
}
