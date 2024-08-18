//
//  MoviesViewController.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class MoviesViewController: UIViewController {

    private let movieItems = Array(repeating: "TEST", count: 5)
    private var reusableCollectionView: GenericCollectionView<String, MovieCollectionViewCell>?
    
    private var isGridView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Switch", style: .plain, target: self, action: #selector(switchLayout))
    }
    
    @objc private func switchLayout() {
        isGridView.toggle()
        let layout = isGridView ? LayoutOptions.createGridLayout() : LayoutOptions.createListLayout()
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.reusableCollectionView?.visibleCells.forEach { cell in
                cell.alpha = 0.0
            }
        }) { [weak self] _ in
            self?.reusableCollectionView?.setLayout(layout: layout)
            self?.reusableCollectionView?.reloadData()
            UIView.animate(withDuration: 0.3) {
                self?.reusableCollectionView?.visibleCells.forEach { cell in
                    cell.alpha = 1.0
                }
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        let frame = adjustedFrame()
        setupMoviesCollestionView(with: frame)
    }
    
    private func setupMoviesCollestionView(with frame: CGRect) {
        let collectionView = GenericCollectionView<String, MovieCollectionViewCell>(
            frame: frame,
            layout: LayoutOptions.createListLayout(),
            items: movieItems,
            configureCell: { _, cell in
                cell.backgroundColor = .red
            }, didSelectItem: { _ in
                print("Item selected")
            }
        )
        reusableCollectionView = collectionView
        if let collectionView = reusableCollectionView {
            view.addSubview(collectionView)
        }
    }
    
    private func adjustedFrame() -> CGRect {
        return view.bounds.insetBy(
            dx: 0,
            dy: tabBarController?.tabBar.frame.height ?? 0
        )
    }
}
