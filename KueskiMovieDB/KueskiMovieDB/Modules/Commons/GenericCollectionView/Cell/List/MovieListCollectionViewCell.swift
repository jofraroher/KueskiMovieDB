//
//  MovieListCollectionViewCell.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit
import SDWebImage

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var model: Movie?
    
    // MARK: - UI Components
    
    let mainContainerView = MovieListCollectionViewCell.makeContainerView(
        cornerRadius: 15,
        backgroundColor: .systemGray6
    )
    let imageContainerView = MovieListCollectionViewCell.makeContainerView(cornerRadius: 15, backgroundColor: .clear)
    let posterImageView = MovieListCollectionViewCell.makePosterImage()
    
    let movieTitleLabel = MovieListCollectionViewCell.makeLabel(
        textAlignment: .left,
        font: UIFont.preferredFont(forTextStyle: .body, weight: .bold)
    )
    let favoritesImage = MovieListCollectionViewCell.makeImageView(
        systemImageName: GenericCellConstants.favoriteImageUnselected,
        tintColor: .red
    )
    
    let movieDetailsContainerStackView = MovieListCollectionViewCell.makeStackView(
        axis: .vertical,
        spacing: 2
    )
    let generalMovieInfoLabel = MovieListCollectionViewCell.makeLabel(
        textAlignment: .left,
        font: UIFont.preferredFont(forTextStyle: .caption1, weight: .light)
    )
    let movieGenresLabel = MovieListCollectionViewCell.makeLabel(
        textAlignment: .left,
        numberOfLines: 2,
        font: UIFont.preferredFont(forTextStyle: .caption1, weight: .light)
    )
    let movieOverviewLabel = MovieListCollectionViewCell.makeLabel(
        textAlignment: .justified,
        numberOfLines: 3,
        font: UIFont.preferredFont(forTextStyle: .callout, weight: .regular, size: 12)
    )
    
    let popularityImage = MovieListCollectionViewCell.makeImageView(
        systemImageName: GenericCellConstants.popularityImage,
        tintColor: .systemBlue
    )
    let popularityRateLabel = MovieListCollectionViewCell.makeLabel(
        textAlignment: .right,
        font: UIFont.preferredFont(forTextStyle: .caption1, weight: .light)
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
    
    func configureCell(model: Movie) {
        configureFavoriteButton(isFavorite: model.isFavorite)
        configureLabels(with: model)
        loadImage(from: model.posterPath)
        self.model = model
    }
    
    private func configureFavoriteButton(isFavorite: Bool) {
        let imageName = isFavorite ? GenericCellConstants.favoriteImageSelected : GenericCellConstants.favoriteImageUnselected
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        favoritesImage.image = image
        favoritesImage.tintColor = .red
    }
    
    private func configureLabels(with model: Movie) {
        movieTitleLabel.text = model.title
        generalMovieInfoLabel.text = String(
            format: GenericCellConstants.stringFormatForMovieInfo, 
            model.releaseDate,
            model.originalLanguage.uppercased()
        )
        movieGenresLabel.text = model.genreIds.toGenreString()
        movieOverviewLabel.text = model.overview
        popularityRateLabel.text = model.voteCount.formatted
    }
    
    private func loadImage(from path: String?) {
        guard let path = path,
              let pathUrl = GetMovieImageEndpoint(urlParams: ImageQueryParams(imagePath: path)).url else {
            posterImageView.image = nil
            return
        }
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        posterImageView.sd_setImage(with: pathUrl) { [weak self] image, error, _, _ in
            if error != nil {
                self?.posterImageView.image = GenericCellConstants.notImageAvailable
            } else {
                self?.posterImageView.image = image
            }
        }
    }
}
