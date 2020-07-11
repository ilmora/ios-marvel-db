//
//  SearchResultCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {
  let resultTitle: UILabel
  let resultTypeImage: UIImageView
  private let container: UIStackView

  private func setupView() {
    container.translatesAutoresizingMaskIntoConstraints = false
    resultTypeImage.translatesAutoresizingMaskIntoConstraints = false

    container.axis = .horizontal
    container.distribution = .fill
    container.spacing = 15
    container.alignment = .center
    container.addArrangedSubview(resultTypeImage)
    container.addArrangedSubview(resultTitle)

    contentView.addSubview(container)
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

      resultTypeImage.widthAnchor.constraint(equalTo: resultTypeImage.heightAnchor)
    ])
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    resultTitle = UILabel()
    resultTypeImage = UIImageView()
    container = UIStackView()
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
