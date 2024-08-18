//
//  MoviesViewController.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    private let movieItems = Array(repeating: "TEST", count: 5)
    private var reusableCollectionView: GenericCollectionView<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Switch", style: .plain, target: self, action: #selector(toggleLayout))
    }
    
    private func setupUI() {
        let frame = adjustedFrame()
        setupMoviesCollectionView(with: frame)
    }
    
    private func setupMoviesCollectionView(with frame: CGRect) {
        let initialLayout = ListCollectionViewLayout()
        reusableCollectionView = GenericCollectionView(
            frame: frame,
            layout: initialLayout,
            items: movieItems,
            configureCell: { item, cell in
                // Configure cell based on the layout
                if cell is MovieGridCollectionViewCell {
                    // Configure grid cell
                } else if cell is MovieListCollectionViewCell {
                    // Configure list cell
                }
            },
            didSelectItem: { item in
                print("Item selected: \(item)")
            }
        )
        view.addSubview(reusableCollectionView)
    }
    
    private func adjustedFrame() -> CGRect {
        return view.bounds.insetBy(
            dx: 0,
            dy: tabBarController?.tabBar.frame.height ?? 0
        )
    }
    
    var flag = true
    
    @objc func toggleLayout() {
        flag = !flag
        let newLayout = flag
        ? ListCollectionViewLayout()
        : GridCollectionViewLayout()
        
        reusableCollectionView.setLayoutWithAnimation(layout: newLayout)
    }
}
