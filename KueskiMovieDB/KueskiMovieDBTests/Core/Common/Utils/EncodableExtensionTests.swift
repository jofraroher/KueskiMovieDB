//
//  EncodableExtensionTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

struct ExampleModel: Encodable, Equatable {
    let name: String
    let age: Int
    let isStudent: Bool
}

final class EncodableExtensionTests: XCTestCase {

    func testDictionaryRepresentation() {
        let example = ExampleModel(name: "John", age: 25, isStudent: true)
        
        let dictionary = example.dictionary
        
        XCTAssertEqual(dictionary["name"] as? String, "John")
        XCTAssertEqual(dictionary["age"] as? Int, 25)
        XCTAssertEqual(dictionary["isStudent"] as? Bool, true)
    }

    func testSubscriptAccess() {
        let example = ExampleModel(name: "Jane", age: 30, isStudent: false)
        
        XCTAssertEqual(example["name"] as? String, "Jane")
        XCTAssertEqual(example["age"] as? Int, 30)
        XCTAssertEqual(example["isStudent"] as? Bool, false)
    }

    func testEmptyModel() {
        struct EmptyModel: Encodable {}
        let empty = EmptyModel()
        
        let dictionary = empty.dictionary
        XCTAssertTrue(dictionary.isEmpty)
    }

    func testSubscriptNonExistentKey() {
        let example = ExampleModel(name: "Jake", age: 28, isStudent: true)
        
        XCTAssertNil(example["nonExistentKey"])
    }

    func testDictionaryWithOptionalValues() {
        struct OptionalModel: Encodable {
            let name: String?
            let age: Int?
        }

        let example = OptionalModel(name: "Alice", age: nil)
        
        let dictionary = example.dictionary
        XCTAssertEqual(dictionary["name"] as? String, "Alice")
        XCTAssertNil(dictionary["age"])
    }
}
