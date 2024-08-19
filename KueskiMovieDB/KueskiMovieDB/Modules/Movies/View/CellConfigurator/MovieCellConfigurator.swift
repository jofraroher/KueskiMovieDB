//
//  MovieCellConfigurator.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class MovieCellConfigurator: CellConfigurator {
    func configureCell(_ cell: UICollectionViewCell, with item: Movie, and delegate: GenericCollectionViewCellDelegate?) {
        if let gridCell = cell as? MovieGridCollectionViewCell {
            gridCell.configureCell(model: item)
        } else if let listCell = cell as? MovieListCollectionViewCell {
            listCell.configureCell(model: item)
            listCell.delegate = delegate
        }
    }
}
