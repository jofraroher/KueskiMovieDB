//
//  SceneDelegate.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let submodules = (
            nowPlaying: MoviesFactory.build(
                usingNavigationFactory: NavigationBuilder.build,
                repository: NowPlayingMoviesListUseCase(), 
                paginationServiceFactory: NowPlayingServiceFactory()
            ),
            popular: MoviesFactory.build(
                usingNavigationFactory: NavigationBuilder.build,
                repository: PopularMoviesListUseCase(), 
                paginationServiceFactory: PopularPaginationServiceFactory()
            )
        )
        let movieTabBarController = TabBarFactory.build(usingSubmodules: submodules)
        window?.rootViewController = movieTabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let _ = CoreDataStack.shared
    }
}

