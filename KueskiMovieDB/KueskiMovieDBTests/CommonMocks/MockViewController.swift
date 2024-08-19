//
//  MockViewController.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import UIKit

final class MockViewController: UIViewController {
    var mockNavigationController: MockNavigationController?
    
    override var navigationController: UINavigationController? {
        return mockNavigationController
    }
}
