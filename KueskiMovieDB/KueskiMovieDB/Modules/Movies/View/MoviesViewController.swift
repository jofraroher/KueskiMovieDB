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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        let frame = adjustedFrame()
        setupMoviesCollestionView(with: frame)
    }
    
    private func setupMoviesCollestionView(with frame: CGRect) {
        let collectionView = GenericCollectionView<String, MovieCollectionViewCell>(
            frame: frame,
            items: movieItems,
            configureCell: { _, _ in
                print("Configure cell")
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
