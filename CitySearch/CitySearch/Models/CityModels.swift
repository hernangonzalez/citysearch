//
//  CityModels.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 09/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

// MARK: - Models
struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

struct City: Codable {
    let id: Int
    let key: String
    let name: String
    let country: String
    let coord: Coordinate

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, key, country, coord
    }
}

private extension City {
    static func == (lhs: Self, rhs: String) -> Bool {
        lhs.key.starts(with: rhs)
    }

    static func < (lhs: City, rhs: String) -> Bool {
        lhs.key < rhs
    }
}

// MARK: - Lookup
extension Array where Element == City {
    func index(of key: String) -> Index? {
        var lowerBound = 0
        var upperBound = count
        while lowerBound < upperBound {
            let midIndex = lowerBound + (upperBound - lowerBound) / 2
            if self[midIndex] == key {
                return midIndex
            } else if self[midIndex] < key {
                lowerBound = midIndex + 1
            } else {
                upperBound = midIndex
            }
        }
        return nil
    }

    private func findBound(at index: Int, key: String, op: (Index) -> (Index)) -> Index {
        let bounds = 0 ..< count
        var match = index
        var next = op(index)
        while bounds.contains(next) && self[next] == key {
            match = next
            next = op(next)
        }
        return match
    }

    func range(matching key: String) -> Range<Index>? {
        let key = key.lowercased()

        guard !isEmpty, !key.isEmpty, let pivot = index(of: key) else {
            return nil
        }
        let upperBound = findBound(at: pivot, key: key) { $0 + 1 }
        let lowerBound = findBound(at: pivot, key: key) { $0 - 1 }
        return lowerBound ..< (upperBound + 1)
    }

    var range: Range<Index> {
        startIndex ..< endIndex
    }
}
