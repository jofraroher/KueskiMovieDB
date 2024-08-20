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
            title: TabBarConstants.nowPlayingTabBarTitle,
            image: TabBarConstants.nowPlayingUnselectedTabBarItem,
            selectedImage: TabBarConstants.nowPlayingSelectedTabBarItem
        )
        let popularTabBarItem = UITabBarItem(
            title: TabBarConstants.popularTabBarTitle,
            image: TabBarConstants.popularUnselectedTabBarItem,
            selectedImage: TabBarConstants.popularSelectedTabBarItem
        )
        
        submodules.nowPlaying.tabBarItem = nowPlayingTabBarItem
        submodules.popular.tabBarItem = popularTabBarItem
        
        return (
            nowPlaying: submodules.nowPlaying,
            popular: submodules.popular
        )
    }
}
