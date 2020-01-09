//
//  ViewController.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 09/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARKK: Constants
    private static let cityCellID = "cityCell"
    private static let rowHeight: CGFloat = 64

    // MARK: Model
    private let viewModel: MainViewViewModel

    // MARK: Properties
    private weak var collectionView: UICollectionView!

    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar(frame: .zero)
        bar.delegate = self
        return bar
    }()

    // MARK: Lifecycle
    init(model: MainViewViewModel) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Appearence
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.register(SearchCityCell.self, forCellWithReuseIdentifier: Self.cityCellID)
        collection.dataSource = self
        collection.delegate = self

        view.backgroundColor = .white
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView = collection
        viewModel.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.bottom = view.safeAreaInsets.bottom
    }

    // MARK: Navigation
    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        item.titleView = searchBar
        return item
    }
}

// MARK: - MainViewViewModelDelegate
extension MainViewController: MainViewViewModelDelegate {
    func viewNeedsUpdate() {
        assert(Thread.isMainThread)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cityCellID, for: indexPath) as! SearchCityCell
        let model = viewModel.searchResult(at: indexPath.item)
        cell.update(with: model)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint(indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width, height: Self.rowHeight)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(by: searchText)
    }
}
