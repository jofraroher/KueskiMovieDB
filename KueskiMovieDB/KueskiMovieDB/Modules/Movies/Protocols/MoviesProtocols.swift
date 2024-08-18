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
}

protocol MoviesInteractorProtocol: AnyObject {
    func getMovieList(queryParams: MoviesQueryParams) async throws -> [Movie] 
}

protocol CellConfigurator: AnyObject {
    func configureCell(_ cell: UICollectionViewCell, with item: Movie)
}

protocol LayoutProvider {
    func createLayout() -> UICollectionViewLayout
}
