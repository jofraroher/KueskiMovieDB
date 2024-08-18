//
//  LayoutManager.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

enum LayoutType {
    case list
    case grid
}

protocol LayoutManagerProtocol {
    func switchLayout(to type: LayoutType)
    func currentLayout() -> UICollectionViewLayout
}

final class LayoutManager: LayoutManagerProtocol {
    private let listLayoutProvider: LayoutProvider
    private let gridLayoutProvider: LayoutProvider
    private var currentType: LayoutType = .list

    init(listLayoutProvider: LayoutProvider, gridLayoutProvider: LayoutProvider) {
        self.listLayoutProvider = listLayoutProvider
        self.gridLayoutProvider = gridLayoutProvider
    }

    func switchLayout(to type: LayoutType) {
        currentType = type
    }

    func currentLayout() -> UICollectionViewLayout {
        switch currentType {
        case .list:
            return listLayoutProvider.createLayout()
        case .grid:
            return gridLayoutProvider.createLayout()
        }
    }
}
