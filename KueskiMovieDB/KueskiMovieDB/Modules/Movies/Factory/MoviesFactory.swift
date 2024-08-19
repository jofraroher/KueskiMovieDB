//
//  MoviesFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

enum MoviesFactory {

    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let interactor = MoviesInteractor(
            repository: NowPlayingMoviesListUseCase(),
            databaseRepository: DatabaseManager(databaseService: DependencyContainer.shared.databaseService)
        )
        let presenter = MoviesPresenter(
            interactor: interactor,
            movieStorageService: MovieStorageService(interactor: interactor),
            paginationServiceFactory: PaginationServiceFactory(), 
            syncService: MovieSyncService()
        )
        let view = MoviesViewController(
            presenter: presenter,
            layoutManager: LayoutManager(
                listLayoutProvider: ListLayoutProvider(),
                gridLayoutProvider: GridLayoutProvider()
            ),
            collectionViewFactory: CollectionViewFactory(cellConfigurator: MovieCellConfigurator())
        )
        presenter.view = view
        return factory(view)
    }
}
