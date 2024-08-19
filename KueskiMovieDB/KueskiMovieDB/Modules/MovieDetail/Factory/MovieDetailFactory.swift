//
//  MovieDetailFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import UIKit
import SwiftUI

enum MovieDetailFactory {
    
    static func build() -> UIViewController {
        let host = UIHostingController(rootView: MovieDetailView())
        host.hidesBottomBarWhenPushed = true
        return host
    }
}
