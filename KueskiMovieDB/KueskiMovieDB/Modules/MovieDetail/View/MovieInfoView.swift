//
//  MovieInfoView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

struct MovieInfoView: View {
    let title: String
    let releaseDate: String
    let genres: String
    let rating: String
    let likes: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(String(format: MovieDetailConstants.releaseDateTitle, releaseDate))
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(genres)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
            MovieRatingView(rating: rating)
            MovieLikesView(likes: likes)
        }
    }
}
