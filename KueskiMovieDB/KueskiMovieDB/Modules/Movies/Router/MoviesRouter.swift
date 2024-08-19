//
//  MoviesRouter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import UIKit

final class MoviesRouter: MoviesRouterProtocol {
    var view: UIViewController?
    
    func navigateToMovieDetail(model: Movie) {
        let controller = MovieDetailFactory.build(model: model)
        view?.navigationController?.pushViewController(controller, animated: true)
    }
}
