//
//  MockNavigationFactory.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import UIKit

final class MockNavigationFactory {
    var buildCalled = false
    var viewControllerToReturn: UINavigationController?

    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        buildCalled = true
        return viewControllerToReturn ?? UINavigationController(rootViewController: rootViewController)
    }
}
