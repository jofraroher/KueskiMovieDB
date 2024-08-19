//
//  MovieEntity+CoreDataProperties.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//
//

import Foundation
import CoreData

extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String
    @NSManaged public var genreIds: Array<Any>?
    @NSManaged public var id: Int64
    @NSManaged public var originalLanguage: String
    @NSManaged public var originalTitle: String
    @NSManaged public var overview: String
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String
    @NSManaged public var releaseDate: String
    @NSManaged public var title: String
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Double

}

extension MovieEntity : Identifiable {

}

extension MovieEntity: StorableEntityProtocol {
    func populateEntity(from domainObject: Any, context: NSManagedObjectContext) throws {
        guard let movie = domainObject as? Movie else {
            throw KueskiMovieDatabaseError.invalidEntityType
        }
        let genreAnyArray: [Any] = movie.genreIds.map { $0.rawValue as Any }
        self.adult = movie.adult
        self.backdropPath = movie.backdropPath
        self.genreIds = genreAnyArray
        self.id = Int64(movie.id)
        self.originalLanguage = movie.originalLanguage
        self.originalTitle = movie.originalTitle
        self.overview = movie.overview
        self.popularity = movie.popularity
        self.posterPath = movie.posterPath
        self.releaseDate = movie.releaseDate
        self.title = movie.title
        self.video = movie.video
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
    }
}

extension MovieEntity: DomainObjectConvertible {
    
    typealias DomainType = Movie
    
    static func fetchReques() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: MovieEntity.description())
    }
    
    func toDomainObject() -> Movie {
        let genreIds: [Int] = self.genreIds?.compactMap { $0 as? Int } ?? []
        return Movie(
            adult: self.adult,
            backdropPath: self.backdropPath,
            genreIds: genreIds.map { GenreType(rawValue: $0) ?? .notFound },
            id: Int(self.id),
            originalLanguage: self.originalLanguage,
            originalTitle: self.originalTitle,
            overview: self.overview,
            popularity: self.popularity,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            title: self.title,
            video: self.video,
            voteAverage: self.voteAverage,
            voteCount: self.voteCount
        )
    }
}
