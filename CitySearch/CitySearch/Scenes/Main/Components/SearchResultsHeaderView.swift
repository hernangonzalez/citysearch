//
//  SearchResultsHeaderView.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import UIKit

class SearchResultsHeaderView: UICollectionReusableView {
    private weak var messageLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray

        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .lightText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])

        messageLabel = label
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = nil
    }

    func update(with count: Int) {
        messageLabel.text = "Showing \(count) cities."
    }
}
