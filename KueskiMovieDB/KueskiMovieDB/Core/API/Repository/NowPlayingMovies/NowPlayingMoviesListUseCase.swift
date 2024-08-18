//
//  NowPlayingMoviesListUseCase.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol NowPlayingMoviesListUseCaseProtocol {
    func execute(queryParams: MoviesQueryParams) async throws -> [Movie]
}

final class NowPlayingMoviesListUseCase: NowPlayingMoviesListUseCaseProtocol {
    
    private let apiClient: AsyncRepository
    
    init(apiClient: AsyncRepository = DefaultAsyncRepository(tokenProvider: AuthorizationTokenProviderManager.getTokenAuthorization()) ) {
        self.apiClient = apiClient
    }
    
    func execute(queryParams: MoviesQueryParams) async throws -> [Movie] {
        let endPoint = GetNowPlayingMoviesEndpoint(queryParams: queryParams.dictionary)
        let response = try await apiClient.request(
            request: endPoint,
            responseType: MovieResponse.self,
            retries: 0
        )
        return response.results
    }
}
