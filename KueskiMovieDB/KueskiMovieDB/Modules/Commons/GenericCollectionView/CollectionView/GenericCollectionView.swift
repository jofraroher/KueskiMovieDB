//
//  GenericCollectionView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class GenericCollectionView<Item, Cell: UICollectionViewCell>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Properties
    private var items: [Item]
    private var configureCell: (Item, Cell) -> ()
    private var didSelectItem: (Item) -> ()
    
    // MARK: - Initializers
    init(
        frame: CGRect = .zero,
        layout: UICollectionViewLayout = UICollectionViewFlowLayout(),
        items: [Item],
        configureCell: @escaping (Item, Cell) -> (),
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
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: Cell.self))")
        }
        configureCell(items[indexPath.row], cell)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(items[indexPath.row])
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .white
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        registerCells()
    }
    
    private func registerCells() {
        self.register(Cell.self, forCellWithReuseIdentifier: String(describing: Cell.self))
    }
}

extension GenericCollectionView {
    func setLayout(layout: UICollectionViewLayout) {
        setCollectionViewLayout(layout, animated: true)
    }
}
