//
//  MoviesQueryParams.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

struct MoviesQueryParams {

    let includeAdult: String
    
    let includeVideo: String
    
    let language: String
    
    let page: Int
    
    let sortBy: String
    
    var withReleaseType: String?
    
    var minDate: String?
    
    var maxDate: String?
    
    /// Query params for most popular movies
    /// - Parameters:
    ///   - includeAdult: A filter and include or exclude adult movies.
    ///   - includeVideo: A filter and include or exclude videos.
    ///   - language: Get translated values
    ///   - page: Page number
    ///   - sortBy: Choose from one of the many available sort options.
    ///   - withReleaseType: Specify the type of release
    ///   - minDate: Filter and only include movies that have a primary release date that is greater or equal to the specified value.
    ///   - maxDate: Filter and only include movies that have a release date (looking at all release dates) that is greater or equal to the specified value.
    init(
        includeAdult: Bool = false,
        includeVideo: Bool = false,
        language: LanguageType = .englishUS,
        popularMovies page: Int,
        sortBy: SortByType = .popularityDesc
    ) {
        self.includeAdult = includeAdult.description
        self.includeVideo = includeVideo.description
        self.language = language.rawValue
        self.page = page
        self.sortBy = sortBy.rawValue
    }
    
    /// Query params for now playing movies
    /// - Parameters:
    ///   - includeAdult: A filter and include or exclude adult movies.
    ///   - includeVideo: A filter and include or exclude videos.
    ///   - language: Get translated values
    ///   - page: Page number
    ///   - sortBy: Choose from one of the many available sort options.
    ///   - withReleaseType: Specify the type of release
    ///   - minDate: Filter and only include movies that have a primary release date that is greater or equal to the specified value.
    ///   - maxDate: Filter and only include movies that have a release date (looking at all release dates) that is greater or equal to the specified value.
    init(
        includeAdult: Bool = false,
        includeVideo: Bool = false,
        language: LanguageType = .englishUS,
        nowPlayingMovies page: Int,
        sortBy: SortByType = .popularityDesc,
        withReleaseType: [ReleaseType] = [.theatricalLimited, .theatrical],
        minDate: Date = Date().subtracting(years: 1),
        maxDate: Date = Date()
    ) {
        self.includeAdult = includeAdult.description
        self.includeVideo = includeVideo.description
        self.language = language.rawValue
        self.page = page
        self.sortBy = sortBy.rawValue
        self.withReleaseType = withReleaseType.formattedString
        self.minDate = minDate.toFormattedString()
        self.maxDate = maxDate.toFormattedString()
    }
}

extension MoviesQueryParams: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case includeAdult = "include_adult"
        case includeVideo = "include_video"
        case language
        case page
        case sortBy = "sort_by"
        case withReleaseType = "with_release_type"
        case minDate = "release_date.gte"
        case maxDate = "release_date.lte"
    }
}
