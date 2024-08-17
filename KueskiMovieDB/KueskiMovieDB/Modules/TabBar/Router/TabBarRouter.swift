//
//  TabBarRouter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class TabBarRouter {
    
    private let viewController: UIViewController

    typealias Submodules = (
        nowPlaying: UIViewController,
        popular: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension TabBarRouter {
    
    static func tabs(usingSubmodules submodules: Submodules) -> MovieTabs {
        let nowPlayingTabBarItem = UITabBarItem(
            title: "Now Playing",
            image: UIImage(systemName: "play"),
            selectedImage: UIImage(systemName: "play.fill")
        )
        let popularTabBarItem = UITabBarItem(
            title: "Popular",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        submodules.nowPlaying.tabBarItem = nowPlayingTabBarItem
        submodules.popular.tabBarItem = popularTabBarItem
        
        return (
            nowPlaying: submodules.nowPlaying,
            popular: submodules.popular
        )
    }
}
