//
//  MainViewViewModel.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 09/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation

protocol MainViewViewModelDelegate: AnyObject {
    func viewNeedsUpdate()
}

class MainViewViewModel {
    private let queue = DispatchQueue(label: "queue.search")
    private var items: [City] = .init()
    private var range: Range<Int> = 0..<0 {
        didSet {
            DispatchQueue.main.async { [weak delegate] in
                delegate?.viewNeedsUpdate()
            }
        }
    }
    weak var delegate: MainViewViewModelDelegate?
}

extension MainViewViewModel {
    var numberOfItems: Int { range.count }

    func searchResult(at index: Int) -> SearchCityCellViewModel {
        let index = range.startIndex + index
        let city = items[index]
        return SearchCityModel(from: city)
    }
}

extension MainViewViewModel {
    func prepareForUse() {
        do {
            let fileURL = Bundle.main.url(forResource: "cities_v2", withExtension: "json")!
            let data = try Data(contentsOf: fileURL)

            /// Map models
            let decoder = JSONDecoder()
            items = try decoder.decode([City].self, from: data)
            range = items.startIndex..<items.endIndex
            print("Loaded \(items.count) models.")
        } catch {
            print("Could not load city content")
        }
    }

    func filter(by prefix: String) {
        let items = self.items
        queue.async {
            self.range = Int.random(in: 1...items.count / 2) ..< items.count / 2 + Int.random(in: 0...items.count / 2)
        }
    }
}

// MARK: - SearchCityModel
private struct SearchCityModel: SearchCityCellViewModel {
    let title: String
    var subtitle: String
}

extension SearchCityModel {
    init(from city: City) {
        title = [city.name, city.country].joined(separator: ", ")
        subtitle = "\(city.coord.lat), \(city.coord.lon)"
    }
}

