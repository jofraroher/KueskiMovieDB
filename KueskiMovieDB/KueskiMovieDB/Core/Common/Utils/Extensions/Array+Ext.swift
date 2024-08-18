//
//  Array.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

extension Array where Element == ReleaseType {
    var formattedString: String {
        return map { "\($0.rawValue)" }.joined(separator: "|")
    }
}

extension Array where Element == GenreType {
    func toGenreString() -> String {
        return self.map { $0.genreName }.joined(separator: ", ")
    }
}
