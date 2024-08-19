//
//  MovieDetailView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 150, height: 220)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 220)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 220)
                            .cornerRadius(10)
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 220)
                            .cornerRadius(10)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Release Date")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("2024-07-30")
                        .font(.body)
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("5.5")
                    }
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Text("127,231")
                    }
                }
                .font(.headline)
            }
            
            Text("Overview")
                .font(.title2)
                .bold()
                .padding(.top)
            
            Text("When a young barrio lass moves in to the city to study, she lives in a boarding house with other college students. Unknown to them, behind her shy and timid personality is a woman with insatiable hunger for sex.")
                .font(.body)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
                // Acción para el botón de "Saved"
            }) {
                HStack {
                    Image(systemName: "star")
                    Text("Saved")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Init")
        .navigationBarTitleDisplayMode(.inline)
    }
}
