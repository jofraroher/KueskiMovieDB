//
//  NavigationFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

enum NavigationBuilder {
    
    static func build(rootView: UIViewController) -> UINavigationController {
       UINavigationController(rootViewController: rootView)
    }
}
