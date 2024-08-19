//
//  MovieHeaderView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

struct MovieHeaderView: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            MoviePosterView(urlString: movie.posterPath)
            
            MovieInfoView(
                title: movie.title,
                releaseDate: movie.releaseDate,
                genres: movie.genreIds.toGenreString(),
                rating: String(movie.popularity),
                likes: movie.voteCount.formatted
            )
        }
    }
}
