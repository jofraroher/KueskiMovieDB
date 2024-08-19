//
//  MovieGridCollectionViewCell.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit
import SDWebImage

final class MovieGridCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    let mainContainerView = MovieGridCollectionViewCell.makeContainerView(
        cornerRadius: 15,
        backgroundColor: .systemGray6
    )
    let imageContainerView = MovieGridCollectionViewCell.makeContainerView(
        cornerRadius: 15,
        backgroundColor: .clear
    )
    let posterImageView = MovieListCollectionViewCell.makePosterImage()
    
    let movieDetailsContainerStackView = MovieGridCollectionViewCell.makeStackView(
        axis: .vertical,
        spacing: 2
    )
    let movieTitleLabel = MovieGridCollectionViewCell.makeLabel(
        textAlignment: .center,
        font: UIFont.preferredFont(forTextStyle: .body, weight: .bold)
    )
    let generalMovieInfoLabel = MovieGridCollectionViewCell.makeLabel(
        textAlignment: .left,
        font: UIFont.preferredFont(forTextStyle: .caption1, weight: .light)
    )
    let movieGenresLabel = MovieGridCollectionViewCell.makeLabel(
        textAlignment: .left,
        numberOfLines: 2,
        font: UIFont.preferredFont(forTextStyle: .caption1, weight: .light)
    )
    let movieOverviewLabel = MovieGridCollectionViewCell.makeLabel(
        textAlignment: .justified,
        numberOfLines: 3,
        font: UIFont.preferredFont(forTextStyle: .callout, weight: .regular, size: 12)
    )
    
    let popularityImage = MovieGridCollectionViewCell.makeImageView(
        systemImageName: "hand.thumbsup.fill",
        tintColor: .black
    )
    let popularityRateLabel = MovieGridCollectionViewCell.makeLabel(
        textAlignment: .right,
        font: UIFont.preferredFont(forTextStyle: .caption1, weight: .light)
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
    
    func configureCell(model: Movie) {
        favoritesButton.setImage(model.isFavorite ? UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        movieTitleLabel.text = model.title
        generalMovieInfoLabel.text = "\(model.releaseDate) • \(model.originalLanguage.uppercased())"
        movieGenresLabel.text = model.genreIds.toGenreString()
        movieOverviewLabel.text = model.overview
        popularityRateLabel.text = model.voteCount.formatted
        if let pathUrl = GetMovieImageEndpoint(urlParams: ImageQueryParams(imagePath: model.posterPath)).url {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.sd_setImage(with: pathUrl)
        }
    }
}
