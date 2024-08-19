//
//  GenericCollectionViewCellDelegate.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

protocol GenericCollectionViewCellDelegate: AnyObject {
    func didTapButton(withModel model: Movie)
}
