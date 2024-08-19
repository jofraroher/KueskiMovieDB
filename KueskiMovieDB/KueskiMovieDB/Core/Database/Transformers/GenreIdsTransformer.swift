//
//  GenreIdsTransformer.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

@objc(GenreIdsTransformer)
class GenreIdsTransformer: ValueTransformer {
    
    // Define el tipo de transformador
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    // Transformación de [Int] a String
    override func transformedValue(_ value: Any?) -> Any? {
        guard let genreIds = value as? [GenreType] else { return nil }
                let intValues = genreIds.map { $0.rawValue }
                do {
                    let data = try JSONEncoder().encode(intValues)
                    return data as NSData
                } catch {
                    print("Error encoding GenreType array: \(error)")
                    return nil
                }
    }
    
    // Transformación de String a [Int]
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData as Data? else { return nil }
        do {
            let intValues = try JSONDecoder().decode([Int].self, from: data)
            return intValues.compactMap { GenreType(rawValue: $0) }
        } catch {
            print("Error decoding GenreType array: \(error)")
            return nil
        }
    }
}
