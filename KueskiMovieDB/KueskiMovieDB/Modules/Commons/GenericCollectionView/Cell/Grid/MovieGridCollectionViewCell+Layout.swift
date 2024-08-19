//
//  MovieGridCollectionViewCell+Layout.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

extension MovieGridCollectionViewCell {
    
    func addSubViews() {
        contentView.addSubview(mainContainerView)
        [
            imageContainerView,
            movieDetailsContainerStackView,
            popularityImage,
            popularityRateLabel,
            favoritesImage
        ].forEach(mainContainerView.addSubview)
        
        imageContainerView.addSubview(posterImageView)
        
        [
            movieTitleLabel,
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
            imageContainerView.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            imageContainerView.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 10),
            imageContainerView.heightAnchor.constraint(equalToConstant: 140),
            imageContainerView.widthAnchor.constraint(equalToConstant: 90),
            
            // Poster image
            posterImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),

            // Movie Details Container StackView
            movieDetailsContainerStackView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 10),
            movieDetailsContainerStackView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -10),
            movieDetailsContainerStackView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 5),
            movieDetailsContainerStackView.bottomAnchor.constraint(equalTo: popularityImage.topAnchor, constant: -5),
            
            // Popularity Image
            popularityImage.trailingAnchor.constraint(equalTo: movieDetailsContainerStackView.trailingAnchor),
            popularityImage.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -10),
            popularityImage.heightAnchor.constraint(equalToConstant: 18),
            popularityImage.widthAnchor.constraint(equalToConstant: 18),
            
            // Popularity Rate Label
            popularityRateLabel.trailingAnchor.constraint(equalTo: popularityImage.leadingAnchor, constant: -5),
            popularityRateLabel.centerYAnchor.constraint(equalTo: popularityImage.centerYAnchor),
            
            // Favorites Button
            favoritesImage.leadingAnchor.constraint(equalTo: movieDetailsContainerStackView.leadingAnchor),
            favoritesImage.centerYAnchor.constraint(equalTo: popularityImage.centerYAnchor),
            favoritesImage.widthAnchor.constraint(equalToConstant: 30),
            favoritesImage.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
