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
