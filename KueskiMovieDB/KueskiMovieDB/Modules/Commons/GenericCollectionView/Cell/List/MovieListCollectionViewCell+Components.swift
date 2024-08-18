//
//  MovieListCollectionViewCell+Components.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

// MARK: - Factory Methods
extension MovieListCollectionViewCell {
    
    static func makeContainerView(cornerRadius: CGFloat, backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func makeLabel(textAlignment: NSTextAlignment, numberOfLines: Int = 1, font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeFavoritesButton() -> UIButton {
        let button = UIButton()
        let image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func makeStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    static func makeImageView(systemImageName: String, tintColor: UIColor) -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: systemImageName)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
