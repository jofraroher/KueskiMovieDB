//
//  MovieDetailFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import UIKit
import SwiftUI

enum MovieDetailFactory {
    
    static func build(model: Movie) -> UIViewController {
        let interactor = MovieDetailInteractor(
            databaseRepository: DatabaseManager(databaseService: DependencyContainer.shared.databaseService)
        )
        let viewModel = MovieDetailViewModel(movie: model)
        let presenter = MovieDetailPresenter(
            viewModel: MovieDetailViewModel(movie: model),
            movieStorageService: MovieStorageService(interactor: interactor)
        )
        let host = UIHostingController(rootView: MovieDetailView(presenter: presenter))
        host.hidesBottomBarWhenPushed = true
        return host
    }
}
