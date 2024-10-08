//
//  MovieResponse.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import CoreData

struct MovieResponse: Codable, Equatable {
    let results: [Movie]
}

struct Movie {
    
    let adult: Bool
    let backdropPath: String
    let genreIds: [GenreType]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Double
    var isFavorite: Bool = false
}

extension Movie: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? Bool()
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? String()
        let responseGenreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
        genreIds = responseGenreIds.map { GenreType(rawValue: $0) ?? .notFound }
        id = try container.decode(Int.self, forKey: .id)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? String()
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? String()
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? String()
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? Double()
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? String()
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? String()
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? String()
        video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? Bool()
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? Double()
        voteCount = try container.decodeIfPresent(Double.self, forKey: .voteCount) ?? Double()
    }
}

extension Movie: StorableDomainProtocol {
    var idDomain: String {
        String(self.id)
    }
    
    typealias EntityType = MovieEntity
    
    func toEntity(context: NSManagedObjectContext) -> MovieEntity {
        let genreAnyArray: [Any] = self.genreIds.map { $0.rawValue as Any }
        let movieEntity = MovieEntity(context: context)
        movieEntity.adult = self.adult
        movieEntity.backdropPath = self.backdropPath
        movieEntity.genreIds = genreAnyArray
        movieEntity.id = Int64(self.id)
        movieEntity.originalLanguage = self.originalLanguage
        movieEntity.originalTitle = self.originalTitle
        movieEntity.overview = self.overview
        movieEntity.popularity = self.popularity
        movieEntity.posterPath = self.posterPath
        movieEntity.releaseDate = self.releaseDate
        movieEntity.title = self.title
        movieEntity.video = self.video
        movieEntity.voteAverage = self.voteAverage
        movieEntity.voteCount = self.voteCount
        
        return movieEntity
    }
}
