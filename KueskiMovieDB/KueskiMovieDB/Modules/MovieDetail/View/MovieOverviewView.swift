//
//  MovieOverviewView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

struct MovieOverviewView: View {
    let overview: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(MovieDetailConstants.movieOverviewTitle.uppercased())
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
