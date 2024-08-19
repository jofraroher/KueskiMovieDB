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
    weak var delegate: GenericCollectionViewCellDelegate?
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
    let favoritesButton = MovieListCollectionViewCell.makeFavoritesButton()
    
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
        systemImageName: "hand.thumbsup.fill",
        tintColor: .black
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
        favoritesButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        if let movie = self.model {
            delegate?.didTapButton(withModel: movie)
        }
    }
    
    func configureCell(model: Movie) {
        configureFavoriteButton(isFavorite: model.isFavorite)
        configureLabels(with: model)
        loadImage(from: model.posterPath)
        self.model = model
    }
    
    private func configureFavoriteButton(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        favoritesButton.setImage(image, for: .normal)
    }
    
    private func configureLabels(with model: Movie) {
        movieTitleLabel.text = model.title
        generalMovieInfoLabel.text = "\(model.releaseDate) • \(model.originalLanguage.uppercased())"
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
        posterImageView.sd_setImage(with: pathUrl)
    }
}
