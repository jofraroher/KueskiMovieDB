//
//  MoviesFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

enum MoviesFactory {

    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let interactor = MoviesInteractor(repository: NowPlayingMoviesListUseCase())
        let presenter = MoviesPresenter(interactor: interactor)
        let view = MoviesViewController(
            presenter: presenter,
            listLayoutProvider: ListLayoutProvider(),
            gridLayoutProvider: GridLayoutProvider(),
            cellConfigurator: DefaultCellConfigurator()
        )
        presenter.view = view
        return factory(view)
    }
}
