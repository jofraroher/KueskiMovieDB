//
//  ListLayoutProvider.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class ListLayoutProvider: LayoutProvider {
    func createLayout() -> UICollectionViewLayout {
        return ListCollectionViewLayout()
    }
}
