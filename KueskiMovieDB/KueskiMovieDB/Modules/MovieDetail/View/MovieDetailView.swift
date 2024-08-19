//
//  MovieDetailView.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import SwiftUI

struct MovieDetailView<Presenter>: View where Presenter: MovieDetailPresenterProtocol {
    
    @ObservedObject var presenter: Presenter
    
    @State private var showAlert = false
    @State private var errorMessage = "Something went wrong. Please try again later."
    
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
                presenter.saveMovie { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        self.showAlert = true
                    }
                }
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Oops!"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}
