//
//  MovieGridCollectionViewCell.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class MovieGridCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    let mainContainerView = MovieGridCollectionViewCell.makeContainerView(
        cornerRadius: 15,
        backgroundColor: .systemGray6
    )
    let imageContainerView = MovieGridCollectionViewCell.makeContainerView(
        cornerRadius: 15,
        backgroundColor: .red
    )
    
    let movieDetailsContainerStackView = MovieGridCollectionViewCell.makeStackView(
        axis: .vertical,
        spacing: 2
    )
    let movieTitleLabel = MovieGridCollectionViewCell.makeLabel(
        text: "MOVIE TITLE",
        textAlignment: .center
    )
    let generalMovieInfoLabel = MovieGridCollectionViewCell.makeLabel(
        text: "DATE • LANGUAGE",
        textAlignment: .left
    )
    let movieGenresLabel = MovieGridCollectionViewCell.makeLabel(
        text: "GENRES",
        textAlignment: .left,
        numberOfLines: 2
    )
    let movieOverviewLabel = MovieGridCollectionViewCell.makeLabel(
        text: "OVERVIEW",
        textAlignment: .justified
    )
    
    let popularityImage = MovieGridCollectionViewCell.makeImageView(
        systemImageName: "hand.thumbsup.fill",
        tintColor: .black
    )
    let popularityRateLabel = MovieGridCollectionViewCell.makeLabel(
        text: "POPULARITY",
        textAlignment: .right
    )
    let favoritesButton = MovieGridCollectionViewCell.makeFavoritesButton()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .clear
        addSubViews()
        setupConstraints()
    }
}
