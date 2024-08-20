//
//  SaveButton.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

struct SaveButton: View {
    let isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isFavorite ? MovieDetailConstants.popularityImageName : MovieDetailConstants.imageMovieNotSavedName)
                Text(isFavorite ? MovieDetailConstants.savedMovieTitle : MovieDetailConstants.saveMovieTitle)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(isFavorite ? Color.green : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
