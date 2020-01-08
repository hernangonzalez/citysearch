import Cocoa
import Foundation
import CoreLocation

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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        country = try container.decode(String.self, forKey: .country)
        coord = try container.decode(Coordinate.self, forKey: .coord)
        key = name.lowercased()
    }
}

/// Load data
let fileURL = Bundle.main.url(forResource: "cities", withExtension: "json")!
let data = try Data(contentsOf: fileURL)

/// Map models
let decoder = JSONDecoder()
var items = try decoder.decode([City].self, from: data)

/// Sort  based on our new lowercase key to speed up lookups.
items.sort(by: { $0.key < $1.key })

/// Save our optimized models.
let encoder = JSONEncoder()
let encodedData = try encoder.encode(items)
let targetURL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("cities_v2.json")
try encodedData.write(to: targetURL)
