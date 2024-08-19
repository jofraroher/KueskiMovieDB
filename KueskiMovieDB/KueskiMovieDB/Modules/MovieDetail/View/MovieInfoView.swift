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
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(releaseDate)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(genres)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            MovieRatingView(rating: rating)
            MovieLikesView(likes: likes)
        }
    }
}
