//
//  MovieListCollectionViewCell.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Components
        
    let mainContainerView = MovieListCollectionViewCell.makeContainerView(
        cornerRadius: 15,
        backgroundColor: .systemGray6
    )
    let imageContainerView = MovieListCollectionViewCell.makeContainerView(
        cornerRadius: 15,
        backgroundColor: .red
    )
    
    let movieTitleLabel = MovieListCollectionViewCell.makeLabel(
        text: "MOVIE TITLE",
        textAlignment: .left
    )
    let favoritesButton = MovieListCollectionViewCell.makeFavoritesButton()
    
    let movieDetailsContainerStackView = MovieListCollectionViewCell.makeStackView(
        axis: .vertical,
        spacing: 2
    )
    let generalMovieInfoLabel = MovieListCollectionViewCell.makeLabel(
        text: "DATE • LANGUAGE",
        textAlignment: .left
    )
    let movieGenresLabel = MovieListCollectionViewCell.makeLabel(
        text: "GENRES",
        textAlignment: .left,
        numberOfLines: 2
    )
    let movieOverviewLabel = MovieListCollectionViewCell.makeLabel(
        text: "OVERVIEW",
        textAlignment: .justified
    )
    
    let popularityImage = MovieListCollectionViewCell.makeImageView(
        systemImageName: "hand.thumbsup.fill",
        tintColor: .black
    )
    let popularityRateLabel = MovieListCollectionViewCell.makeLabel(
        text: "POPULARITY",
        textAlignment: .right
    )
    
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
