//
//  MovieDetailView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

struct MovieDetailView<Presenter>: View where Presenter: MovieDetailPresenterProtocol {
    
    @ObservedObject var presenter: Presenter
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            MovieHeaderView(movie: presenter.viewModel.movie)
                .padding(.top, 60)
            
            MovieOverviewView(overview: presenter.viewModel.movie.overview)
            
            Spacer()
            
            SaveButton(isFavorite: presenter.viewModel.movie.isFavorite, action: {
                presenter.saveMovie()
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
}

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

struct MoviePosterView: View {
    let urlString: String
    
    var body: some View {
        AsyncImage(url: GetMovieImageEndpoint(urlParams: ImageQueryParams(imagePath: urlString)).url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 220)
                    .cornerRadius(20)
            case .failure:
                Image("noImageAvailable")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 220)
                    .cornerRadius(10)
                    .foregroundStyle(.blue)
            @unknown default:
                Image("noImageAvailable")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 220)
                    .cornerRadius(10)
                    .foregroundStyle(.blue)
            }
        }
    }
}

struct MovieRatingView: View {
    let rating: String
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(rating)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct MovieLikesView: View {
    let likes: String
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
            Text(likes)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct MovieOverviewView: View {
    let overview: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("OVERVIEW")
                .fontWeight(.medium)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(overview)
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct SaveButton: View {
    let isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isFavorite ? "star.fill" : "star")
                Text(isFavorite ? "Saved" : "Save")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(isFavorite ? Color.green : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
