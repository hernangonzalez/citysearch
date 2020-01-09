//
//  SearchCityCell.swift
//  CitySearch
//
//  Created by Hernan G. Gonzalez on 09/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import UIKit

protocol SearchCityCellViewModel {
    var title: String { get }
    var subtitle: String { get }
}

class SearchCityCell: UICollectionViewCell {
    // MARK: Properties
    private weak var titleLabel: UILabel!
    private weak var subtitleLabel: UILabel!

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        let title = UILabel()
        title.font = .preferredFont(forTextStyle: .body)
        title.text = "Titulo"
        title.setContentHuggingPriority(.required, for: .vertical)
        title.setContentCompressionResistancePriority(.required, for: .vertical)
        title.textColor = .darkText

        let subtitle = UILabel()
        subtitle.font = .preferredFont(forTextStyle: .footnote)
        subtitle.text = "Subtitulo"
        subtitle.textColor = .gray

        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [title, subtitle])
        stack.spacing = 8
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        contentView.addSubview(line)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        titleLabel = title
        subtitleLabel = subtitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Cell
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
    }

    // MARK: ViewModel
    func update(with model: SearchCityCellViewModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }

}
