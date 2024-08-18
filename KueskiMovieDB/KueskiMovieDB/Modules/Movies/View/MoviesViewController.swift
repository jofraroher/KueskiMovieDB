//
//  MoviesViewController.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class MoviesViewController: UIViewController {

    private let presenter: MoviesPresenterProtocol
    private let layoutManager: LayoutManagerProtocol
    private let collectionViewFactory: CollectionViewFactoryProtocol

    private var reusableCollectionView: GenericCollectionView<Movie>!

    init(
        presenter: MoviesPresenterProtocol,
        layoutManager: LayoutManagerProtocol,
        collectionViewFactory: CollectionViewFactoryProtocol
    ) {
        self.presenter = presenter
        self.layoutManager = layoutManager
        self.collectionViewFactory = collectionViewFactory
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationComponents()
        presenter.updateMovieList()
    }

    private func setupUI() {
        view.backgroundColor = .white
        let frame = adjustedFrame()
        setupMoviesCollectionView(with: frame)
    }

    private func setupNavigationComponents() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(sortTapped)
        )
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(gridTapped)),
            UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listTapped))
        ]
    }

    private func setupMoviesCollectionView(with frame: CGRect) {
        reusableCollectionView = collectionViewFactory.createCollectionView(
            with: frame,
            layout: layoutManager.currentLayout(),
            items: presenter.items, 
            fetchRemoteData: { [weak self] in
                self?.presenter.updateMovieList()
            }
        )
        view.addSubview(reusableCollectionView)
    }

    private func adjustedFrame() -> CGRect {
        return view.bounds.insetBy(dx: 0, dy: tabBarController?.tabBar.frame.height ?? 0)
    }

    @objc private func sortTapped() {
        let actionSheetController = UIAlertController(title: "Sort by", message: "Choose an option", preferredStyle: .actionSheet)
        let sortOptions: [(title: String, sortBy: SortByType)] = [
            ("Date", .releaseDateDesc),
            ("Name", .originalTitleDesc),
            ("Default", .popularityDesc)
        ]
        
        sortOptions.forEach { option in
            let action = UIAlertAction(title: option.title, style: .default) { [weak self] _ in
                self?.presenter.updateMovieListBySort(sortBy: option.sortBy)
            }
            actionSheetController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
    }

    @objc private func listTapped() {
        toggleLayout(to: .list)
    }

    @objc private func gridTapped() {
        toggleLayout(to: .grid)
    }

    private func toggleLayout(to type: LayoutType) {
        layoutManager.switchLayout(to: type)
        reusableCollectionView.setLayoutWithAnimation(layout: layoutManager.currentLayout())
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func reloadData(items: [Movie]) {
        reusableCollectionView.handleDataLoadCompletion(with: items)
    }
}
