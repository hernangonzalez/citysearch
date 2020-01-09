//
//  ViewController.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 09/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: Views
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar(frame: .zero)
        bar.delegate = self
        return bar
    }()

    // MARK: Lifecycle
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .magenta
    }

    // MARK: Navigation
    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        item.titleView = searchBar
        return item
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint(searchText)
    }
}
