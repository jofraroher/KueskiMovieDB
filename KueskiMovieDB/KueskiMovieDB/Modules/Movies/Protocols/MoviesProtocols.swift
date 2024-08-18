//
//  MoviesProtocols.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

protocol CellConfigurator: AnyObject {
    func configureCell(_ cell: UICollectionViewCell, with item: String)
}

protocol LayoutProvider {
    func createLayout() -> UICollectionViewLayout
}
