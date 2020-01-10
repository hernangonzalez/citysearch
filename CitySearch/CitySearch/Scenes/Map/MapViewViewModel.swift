//
//  MapViewViewModel.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import MapKit

class MapViewViewModel {
    private let city: City

    init(from city: City) {
        self.city = city
    }
}

extension MapViewViewModel {

    var title: String {
        city.name
    }

    var annotation: MKPointAnnotation {
        let model = MKPointAnnotation()
        model.coordinate = .init(latitude: city.coord.lat,
                                 longitude: city.coord.lon)
        return model
    }
}
