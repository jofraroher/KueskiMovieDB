//
//  MoviePosterView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

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
                Image(MovieDetailConstants.imageNoAvailableName)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 220)
                    .cornerRadius(10)
                    .foregroundStyle(.blue)
            @unknown default:
                Image(MovieDetailConstants.imageNoAvailableName)
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
