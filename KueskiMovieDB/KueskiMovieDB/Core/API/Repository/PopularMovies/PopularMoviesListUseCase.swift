//
//  PopularMoviesListUseCase.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

final class PopularMoviesListUseCase: MoviesUseCaseProtocol {

    private let apiClient: AsyncRepository
    
    init(apiClient: AsyncRepository = DefaultAsyncRepository(tokenProvider: AuthorizationTokenProviderManager.getTokenAuthorization()) ) {
        self.apiClient = apiClient
    }
    
    func execute(queryParams: MoviesQueryParams) async throws -> [Movie] {
        let endPoint = GetPopularMoviesEndpoint(queryParams: queryParams.dictionary)
        let response = try await apiClient.request(
            request: endPoint,
            responseType: MovieResponse.self,
            retries: 0
        )
        return response.results
    }
}
