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
                .fixedSize(horizontal: false, vertical: true)
            
            Text("Release Date: \(releaseDate)")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(genres)
                .font(.subheadline)
                .fontWeight(.medium)
            
            MovieRatingView(rating: rating)
            MovieLikesView(likes: likes)
        }
    }
}
