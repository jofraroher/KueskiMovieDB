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
    private var listLayoutProvider: LayoutProvider
    private var gridLayoutProvider: LayoutProvider
    private let cellConfigurator: CellConfigurator
    private var flag = true
    
    // Dependency Injection via Initializer
    init(
        listLayoutProvider: LayoutProvider,
        gridLayoutProvider: LayoutProvider,
        cellConfigurator: CellConfigurator
    ) {
        self.listLayoutProvider = listLayoutProvider
        self.gridLayoutProvider = gridLayoutProvider
        self.cellConfigurator = cellConfigurator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Switch",
            style: .plain,
            target: self,
            action: #selector(toggleLayout)
        )
    }
    
    private func setupUI() {
        let frame = adjustedFrame()
        setupMoviesCollectionView(with: frame)
    }
    
    private func setupMoviesCollectionView(with frame: CGRect) {
        let initialLayout = currentLayoutProvider.createLayout()
        
        let adaptConfigureCell: (String, UICollectionViewCell) -> () = { [weak cellConfigurator] item, cell in
            cellConfigurator?.configureCell(cell, with: item)
        }
        
        reusableCollectionView = GenericCollectionView(
            frame: frame,
            layout: initialLayout,
            items: movieItems,
            configureCell: adaptConfigureCell,
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
    
    @objc func toggleLayout() {
        flag.toggle()
        let newLayoutProvider = flag ? currentLayoutProvider : otherLayoutProvider
        let newLayout = newLayoutProvider.createLayout()
        reusableCollectionView.setLayoutWithAnimation(layout: newLayout)
    }
}
