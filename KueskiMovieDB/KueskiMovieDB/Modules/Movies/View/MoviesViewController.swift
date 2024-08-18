//
//  MoviesViewController.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

class MoviesViewController: UIViewController {

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
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.reusableCollectionView?.setLayout(layout: layout)
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
