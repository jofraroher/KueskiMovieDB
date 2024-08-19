//
//  MoviesRouter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import UIKit

final class MoviesRouter: MoviesRouterProtocol {
    var view: UIViewController?
    
    func navigateToMovieDetail() {
        let controller = MovieDetailFactory.build()
        view?.navigationController?.pushViewController(controller, animated: true)
    }
}
