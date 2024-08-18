//
//  MovieListCollectionViewCell+Layout.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

extension MovieListCollectionViewCell {
    
    func addSubViews() {
        contentView.addSubview(mainContainerView)
        [
            imageContainerView,
            movieTitleLabel,
            favoritesButton,
            movieDetailsContainerStackView,
            popularityImage,
            popularityRateLabel
        ].forEach(mainContainerView.addSubview)
        [
            generalMovieInfoLabel,
            movieGenresLabel,
            movieOverviewLabel
        ].forEach(movieDetailsContainerStackView.addArrangedSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Main Container View
            mainContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Image Container View
            imageContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 10),
            imageContainerView.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 10),
            imageContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -10),
            imageContainerView.widthAnchor.constraint(equalToConstant: 90),
            
            // Movie Title Label
            movieTitleLabel.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: favoritesButton.leadingAnchor, constant: -5),
            movieTitleLabel.centerYAnchor.constraint(equalTo: favoritesButton.centerYAnchor),
            
            // Favorites Button
            favoritesButton.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -10),
            favoritesButton.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            favoritesButton.widthAnchor.constraint(equalToConstant: 30),
            favoritesButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Movie Details Container StackView
            movieDetailsContainerStackView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            movieDetailsContainerStackView.trailingAnchor.constraint(equalTo: favoritesButton.trailingAnchor),
            movieDetailsContainerStackView.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor, constant: 2),
            movieDetailsContainerStackView.bottomAnchor.constraint(equalTo: popularityImage.topAnchor, constant: -2),
            
            // Popularity Image
            popularityImage.trailingAnchor.constraint(equalTo: favoritesButton.trailingAnchor),
            popularityImage.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            popularityImage.heightAnchor.constraint(equalToConstant: 18),
            popularityImage.widthAnchor.constraint(equalToConstant: 18),
            
            // Popularity Rate Label
            popularityRateLabel.trailingAnchor.constraint(equalTo: popularityImage.leadingAnchor, constant: -5),
            popularityRateLabel.centerYAnchor.constraint(equalTo: popularityImage.centerYAnchor)
        ])
    }
}
