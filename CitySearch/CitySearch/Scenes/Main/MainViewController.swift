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
    private static let headerID = "headerView"
    private static let rowHeight: CGFloat = 64
    private static let headerHeight: CGFloat = 40

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
        collection.register(SearchResultsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.headerID)
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.headerID, for: indexPath) as! SearchResultsHeaderView
        view.update(with: viewModel.numberOfItems)
        return view
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.mapModel(at: indexPath.item)
        let scene = MapViewController(model: model)
        show(scene, sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width, height: Self.rowHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.bounds.width, height: Self.headerHeight)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(by: searchText)
    }
}
