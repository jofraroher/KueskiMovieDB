//
//  MoviesViewController.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class MoviesViewController: UIViewController {

    internal let presenter: MoviesPresenterProtocol
    internal let layoutManager: LayoutManagerProtocol
    internal let collectionViewFactory: CollectionViewFactoryProtocol

    internal var reusableCollectionView: GenericCollectionView<Movie>!

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.refreshStatu()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        let frame = adjustedFrame()
        setupMoviesCollectionView(with: frame)
    }

    private func setupNavigationComponents() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: MovieConstants.sortByNavigationItem,
            style: .plain,
            target: self,
            action: #selector(sortTapped)
        )
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: MovieConstants.gridNavigationItem, style: .plain, target: self, action: #selector(gridTapped)),
            UIBarButtonItem(image: MovieConstants.listNavigationTitle, style: .plain, target: self, action: #selector(listTapped))
        ]
    }

    private func setupMoviesCollectionView(with frame: CGRect) {
        reusableCollectionView = collectionViewFactory.createCollectionView(
            with: frame,
            layout: layoutManager.currentLayout(),
            items: presenter.items, 
            fetchRemoteData: { [weak self] in
                self?.presenter.updateMovieList()
            }, didSelectItem: { [weak self] item in
                self?.presenter.navigateToMovieDetail(model: item)
            }
        )
        view.addSubview(reusableCollectionView)
    }

    private func adjustedFrame() -> CGRect {
        return view.bounds.insetBy(dx: 0, dy: tabBarController?.tabBar.frame.height ?? 0)
    }

    @objc internal func sortTapped() {
        let actionSheetController = UIAlertController(title: MovieConstants.sortByAlertTitle, message: MovieConstants.sortByMessageTitle, preferredStyle: .actionSheet)
        let sortOptions: [(title: String, sortBy: SortByType)] = [
            (MovieConstants.sortByDateTitle, .releaseDateDesc),
            (MovieConstants.sortByNameTitle, .originalTitleDesc),
            (MovieConstants.resetSortTitle, .popularityDesc)
        ]
        
        sortOptions.forEach { option in
            let action = UIAlertAction(title: option.title, style: .default) { [weak self] _ in
                self?.presenter.updateMovieListBySort(sortBy: option.sortBy)
            }
            actionSheetController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: MovieConstants.cancelAlertTitle, style: .cancel, handler: nil)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
    }

    @objc internal func listTapped() {
        toggleLayout(to: .list)
    }

    @objc internal func gridTapped() {
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
    
    func showAlert() {
        let alertController = UIAlertController(
            title: MovieConstants.errorAlertTitle,
            message: MovieConstants.errorAlertMessage, preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: MovieConstants.dismissAlertTitle, style: .default) { _ in }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
