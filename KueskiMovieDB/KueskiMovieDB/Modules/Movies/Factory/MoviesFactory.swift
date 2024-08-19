//
//  MoviesFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

enum MoviesFactory {
    
    static func build(
        usingNavigationFactory factory: NavigationFactory,
        repository: MoviesUseCaseProtocol,
        paginationServiceFactory: PaginationServiceFactoryProtocol
    ) -> UIViewController {
        let router = MoviesRouter()
        let interactor = MoviesInteractor(
            repository: repository,
            databaseRepository: DatabaseManager(databaseService: DependencyContainer.shared.databaseService)
        )
        let presenter = MoviesPresenter(
            interactor: interactor,
            movieFetchingService: MovieFetchingService(fetchingInteractor: interactor),
            paginationServiceFactory: paginationServiceFactory,
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
        router.view = view
        
        presenter.router = router
        return factory(view)
    }
}
