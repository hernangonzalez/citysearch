import Cocoa
import Foundation

// MARK: - Models
struct Coordinate: Codable, Equatable {
    let lat: Double
    let lon: Double
}

struct City: Codable, Equatable {
    let _id: Int
    let key: String
    let name: String
    let country: String
    let coord: Coordinate
}

extension City {
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

    func range(matching key: String) -> ClosedRange<Index>? {
        guard !isEmpty, !key.isEmpty, let pivot = index(of: key) else {
            return nil
        }
        let upperBound = findBound(at: pivot, key: key) { $0 + 1 }
        let lowerBound = findBound(at: pivot, key: key) { $0 - 1 }
        return lowerBound ... upperBound
    }
}

/// Load data
let fileURL = Bundle.main.url(forResource: "cities_v2", withExtension: "json")!
let data = try Data(contentsOf: fileURL)

/// Map models
let decoder = JSONDecoder()
var items = try decoder.decode([City].self, from: data)

/// Samples
let range = items.range(matching: "bueno")
let range2 = items.range(matching: "a")
let range3 = items.range(matching: "..invalid...")
let range4 = items.range(matching: "")

