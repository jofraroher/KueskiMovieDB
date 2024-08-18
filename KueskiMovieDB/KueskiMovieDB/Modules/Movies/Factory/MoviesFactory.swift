//
//  MoviesFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

enum MoviesFactory {

    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let view = MoviesViewController(
            listLayoutProvider: ListLayoutProvider(),
            gridLayoutProvider: GridLayoutProvider(),
            cellConfigurator: DefaultCellConfigurator()
        )
        return factory(view)
    }
}
