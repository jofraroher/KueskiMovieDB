//
//  MoviesViewController.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class MoviesViewController: UIViewController {

    private let presenter: MoviesPresenterProtocol
    private let listLayoutProvider: LayoutProvider
    private let gridLayoutProvider: LayoutProvider
    private let cellConfigurator: CellConfigurator

    private var reusableCollectionView: GenericCollectionView<Movie>!

    // Dependency Injection via Initializer
    init(
        presenter: MoviesPresenterProtocol,
        listLayoutProvider: LayoutProvider,
        gridLayoutProvider: LayoutProvider,
        cellConfigurator: CellConfigurator
    ) {
        self.presenter = presenter
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
        setupNavigationComponents()
        presenter.updateMovieList()
    }

    private func setupUI() {
        view.backgroundColor = .white
        let frame = adjustedFrame()
        setupMoviesCollectionView(with: frame)
    }

    private func setupNavigationComponents() {
        let listItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listTapped))
        let gridItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(gridTapped))
        let filterItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(sortTapped))

        navigationItem.leftBarButtonItem = filterItem
        navigationItem.rightBarButtonItems = [gridItem, listItem]
    }

    private func setupMoviesCollectionView(with frame: CGRect) {
        let initialLayout = listLayoutProvider.createLayout()

        let adaptConfigureCell: (Movie, UICollectionViewCell) -> () = { [weak self] item, cell in
            self?.cellConfigurator.configureCell(cell, with: item)
        }

        reusableCollectionView = GenericCollectionView(
            frame: frame,
            layout: initialLayout,
            items: presenter.items,
            configureCell: adaptConfigureCell,
            didSelectItem: { item in
                print("Item selected: \(item)")
            },
            fetchRemoteData: { [weak self] in
                self?.reusableCollectionView.isFetching = true
                self?.presenter.updateMovieList()
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

    @objc private func sortTapped() { }

    @objc private func listTapped() {
        toggleLayout(toggle: true)
    }

    @objc private func gridTapped() {
        toggleLayout(toggle: false)
    }

    func toggleLayout(toggle: Bool) {
        let newLayoutProvider = toggle ? listLayoutProvider : gridLayoutProvider
        let newLayout = newLayoutProvider.createLayout()
        reusableCollectionView.setLayoutWithAnimation(layout: newLayout)
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func reloadData(items: [Movie]) {
        reusableCollectionView.handleDataLoadCompletion(with: items)
    }
}
