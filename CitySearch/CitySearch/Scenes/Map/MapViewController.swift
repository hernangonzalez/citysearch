//
//  MapViewController.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    // MARK: Model
    private let viewModel: MapViewViewModel

    // MARK: Properties
    private weak var mapView: MKMapView!

    // MARK: Lifecycle
    init(model: MapViewViewModel) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Appearence
    override func viewDidLoad() {
        super.viewDidLoad()

        let map = MKMapView(frame: .zero)
        map.addAnnotation(viewModel.annotation)
        map.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(map)
        NSLayoutConstraint.activate([
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        mapView = map
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}
