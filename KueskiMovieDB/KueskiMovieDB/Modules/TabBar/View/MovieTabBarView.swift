//
//  MovieTabBarView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

typealias MovieTabs = (
    nowPlaying: UIViewController,
    popular: UIViewController
)

final class MovieTabBarView: UITabBarController {
    
    init(tabs: MovieTabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [
            tabs.nowPlaying,
            tabs.popular
        ]
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
