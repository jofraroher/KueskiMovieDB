//
//  DefaultCellConfigurator.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class DefaultCellConfigurator: CellConfigurator {
    func configureCell(_ cell: UICollectionViewCell, with item: Movie) {
        if let gridCell = cell as? MovieGridCollectionViewCell {
            // Configura gridCell
        } else if let listCell = cell as? MovieListCollectionViewCell {
            listCell.configureCell(model: item)
        }
    }
}
