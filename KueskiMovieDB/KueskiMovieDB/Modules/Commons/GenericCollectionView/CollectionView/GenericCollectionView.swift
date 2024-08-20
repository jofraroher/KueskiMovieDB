//
//  GenericCollectionView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

class GenericCollectionView<Item>: UICollectionView, UICollectionViewDataSourcePrefetching {
    // MARK: - Properties
    private var items: [Item] = []
    private var genericDataSource: GenericCollectionViewDataSource<Item>?
    private var genericDelegate: GenericCollectionViewDelegate<Item>?
    
    private let fetchRemoteData: () -> ()
    var isFetching: Bool = false
    
    // MARK: - Initializers
    init(
        frame: CGRect = .zero,
        layout: UICollectionViewLayout = UICollectionViewFlowLayout(),
        items: [Item],
        configureCell: @escaping (Item, UICollectionViewCell) -> (),
        didSelectItem: @escaping (Item) -> (),
        fetchRemoteData: @escaping () -> ()
    ) {
        self.items = items
        self.fetchRemoteData = fetchRemoteData
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI(configureCell: configureCell, didSelectItem: didSelectItem)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayoutWithAnimation(layout: UICollectionViewLayout) {
        let oldLayout = collectionViewLayout
        collectionViewLayout = layout

        performBatchUpdates({
            oldLayout.invalidateLayout()
            collectionViewLayout.invalidateLayout()
        }, completion: { _ in
            self.dataSource = self.genericDataSource
            self.delegate = self.genericDelegate
            self.prefetchDataSource = self
            self.reloadData()
        })
    }
    
    func updateItems(with newItems: [Item]) {
        let oldCount = items.count
        items = newItems
        genericDataSource?.updateItems(with: newItems)
        genericDelegate?.updateItems(with: newItems)
        
        guard oldCount != newItems.count else {
            reloadData()
            return
        }

        performBatchUpdates({
            let indexSet = IndexSet(integer: 0)
            reloadSections(indexSet)
        }, completion: nil)
    }
    
    // MARK: - Private Methods
    private func setupUI(configureCell: @escaping (Item, UICollectionViewCell) -> (), didSelectItem: @escaping (Item) -> ()) {
        genericDataSource = GenericCollectionViewDataSource(items: items, configureCell: configureCell)
        genericDelegate = GenericCollectionViewDelegate(items: items, didSelectItem: didSelectItem)
        backgroundColor = .white
        delegate = genericDelegate
        dataSource = genericDataSource
        prefetchDataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        
        // Configuración del UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        register(MovieGridCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieGridCollectionViewCell.self))
        register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieListCollectionViewCell.self))
    }
    
    @objc func refreshData(_ sender: Any) {
        if !isFetching {
            fetchRemoteData()
            isFetching = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row >= items.count {
                print("Index out of range: \(indexPath.row) >= \(items.count)")
                continue
            }
            if indexPath.row >= items.count - 3 && !isFetching {
                fetchRemoteData()
                refreshControl?.beginRefreshing()
                break
            }
        }
    }
    
    func handleDataLoadCompletion(with newItems: [Item]) {
        isFetching = false
        self.refreshControl?.endRefreshing()
        updateItems(with: newItems)
    }
}
