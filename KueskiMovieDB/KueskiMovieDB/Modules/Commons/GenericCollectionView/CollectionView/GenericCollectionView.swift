//
//  GenericCollectionView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class GenericCollectionView<Item>: UICollectionView {
    // MARK: - Properties
    private var genericDataSource: GenericCollectionViewDataSource<Item>?
    private var genericDelegate: GenericCollectionViewDelegate<Item>?
    
    // MARK: - Initializers
    init(
        frame: CGRect = .zero,
        layout: UICollectionViewLayout = UICollectionViewFlowLayout(),
        items: [Item],
        configureCell: @escaping (Item, UICollectionViewCell) -> (),
        didSelectItem: @escaping (Item) -> ()
    ) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI(items: items, configureCell: configureCell, didSelectItem: didSelectItem)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayoutWithAnimation(layout: UICollectionViewLayout) {
        CollectionViewLayoutAnimator.animateLayoutChange(for: self, with: layout)
    }
    
    // MARK: - Private Methods
    private func setupUI(items: [Item], configureCell: @escaping (Item, UICollectionViewCell) -> (), didSelectItem: @escaping (Item) -> ()) {
        genericDataSource = GenericCollectionViewDataSource(items: items, configureCell: configureCell)
        genericDelegate = GenericCollectionViewDelegate(items: items, didSelectItem: didSelectItem)
        backgroundColor = .white
        delegate = genericDelegate
        dataSource = genericDataSource
        translatesAutoresizingMaskIntoConstraints = false
        register(MovieGridCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieGridCollectionViewCell.self))
        register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieListCollectionViewCell.self))
    }
}
