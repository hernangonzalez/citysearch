//
//  CitySearchTests.swift
//  CitySearchTests
//
//  Created by Hernan G. Gonzalez on 09/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import XCTest
@testable import CitySearch

class CitySearchTests: XCTestCase {

    let models: [City] = {
        let fileURL = Bundle.main.url(forResource: "cities_v2", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)

        /// Map models
        let decoder = JSONDecoder()
        return try! decoder.decode([City].self, from: data)
    }()

    func testLoaded() {
        XCTAssertFalse(models.isEmpty)
    }

    func testEmptySetReturnsNil() {
        let models: [City] = .init()
        XCTAssertNil(models.range(matching: "ab"))
    }

    func testEmptyQueryReturnsNil() {
        XCTAssertNil(models.range(matching: ""))
    }

    func testInvalidQueryReturnsNil() {
        XCTAssertNil(models.range(matching: "...123412341234....."))
    }

    func testQuery1() {
        let query = "bue"
        let range = models.range(matching: query)
        XCTAssertNotNil(range)

        let matches = models[range!]
        let valids = matches.reduce(true, { $0 && $1.name.lowercased().starts(with: query) })
        XCTAssertTrue(valids)
    }

    func testQuery2() {
        let query = "m"
        let range = models.range(matching: query)
        XCTAssertNotNil(range)

        let matches = models[range!]
        let valids = matches.reduce(true, { $0 && $1.name.lowercased().starts(with: query) })
        XCTAssertTrue(valids)
    }
}
