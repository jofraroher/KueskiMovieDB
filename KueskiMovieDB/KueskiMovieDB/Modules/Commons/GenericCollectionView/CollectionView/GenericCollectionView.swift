//
//  GenericCollectionView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class GenericCollectionView<Item>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Properties
    private var items: [Item]
    private var configureCell: (Item, UICollectionViewCell) -> ()
    private var didSelectItem: (Item) -> ()
    
    // MARK: - Initializers
    init(
        frame: CGRect = .zero,
        layout: UICollectionViewLayout = UICollectionViewFlowLayout(),
        items: [Item],
        configureCell: @escaping (Item, UICollectionViewCell) -> (),
        didSelectItem: @escaping (Item) -> ()
    ) {
        self.items = items
        self.configureCell = configureCell
        self.didSelectItem = didSelectItem
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayoutWithAnimation(layout: UICollectionViewLayout) {        
        self.setCollectionViewLayout(layout, animated: false)
        
        UIView.performWithoutAnimation {
            self.performBatchUpdates({
                self.reloadData()
            }) { [weak self] _ in
                guard let self = self else { return }
                
                let visibleCells = self.visibleCells
                visibleCells.forEach { cell in
                    cell.alpha = 0.0
                }
                
                UIView.animate(withDuration: 0.3) {
                    visibleCells.forEach { cell in
                        cell.alpha = 1.0
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .white
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(MovieGridCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieGridCollectionViewCell.self))
        register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieListCollectionViewCell.self))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType: UICollectionViewCell.Type
        if collectionView.collectionViewLayout is ListCollectionViewLayout {
            cellType = MovieListCollectionViewCell.self
        } else {
            cellType = MovieGridCollectionViewCell.self
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath)
        configureCell(items[indexPath.row], cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(items[indexPath.row])
    }
}
