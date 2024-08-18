//
//  GridLayoutProvider.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class GridLayoutProvider: LayoutProvider {
    func createLayout() -> UICollectionViewLayout {
        return GridCollectionViewLayout()
    }
}
