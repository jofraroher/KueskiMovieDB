//
//  CollectionViewFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

protocol CollectionViewFactoryProtocol {
    func createCollectionView(
        with frame: CGRect,
        layout: UICollectionViewLayout,
        items: [Movie],
        fetchRemoteData: @escaping (() -> ()),
        cellDelegate: GenericCollectionViewCellDelegate?
    ) -> GenericCollectionView<Movie>
}

final class CollectionViewFactory: CollectionViewFactoryProtocol {
    private let cellConfigurator: CellConfigurator

    init(cellConfigurator: CellConfigurator) {
        self.cellConfigurator = cellConfigurator
    }

    func createCollectionView(
        with frame: CGRect,
        layout: UICollectionViewLayout,
        items: [Movie],
        fetchRemoteData: @escaping (() -> ()),
        cellDelegate: GenericCollectionViewCellDelegate?
    ) -> GenericCollectionView<Movie> {

        let adaptConfigureCell: (Movie, UICollectionViewCell) -> () = { [weak self] item, cell in
            self?.cellConfigurator.configureCell(cell, with: item, and: cellDelegate)
        }

        let collectionView = GenericCollectionView(
            frame: frame,
            layout: layout,
            items: items,
            configureCell: adaptConfigureCell,
            didSelectItem: { item in
                print("Item selected: \(item)")
            },
            fetchRemoteData: fetchRemoteData
        )
        
        return collectionView
    }
}
