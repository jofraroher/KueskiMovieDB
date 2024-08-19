//
//  MockNavigationController.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import UIKit

final class MockNavigationController: UINavigationController {
    var pushViewControllerCalled = false
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    func call(_ viewController: UIViewController) -> UIViewController {
        pushViewControllerCalled = true
        return pushedViewController ?? viewController
    }
}
