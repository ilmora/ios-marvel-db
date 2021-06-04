//
//  SearchResultCharacterCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 04/06/2021.
//  Copyright © 2021 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCharacterCell: UICollectionViewCell {
  let resultTitle: UILabel
  let resultTypeImage: UIImageView
  private let container: UIStackView

  private func setupView() {
    container.translatesAutoresizingMaskIntoConstraints = false
    resultTypeImage.translatesAutoresizingMaskIntoConstraints = false

    resultTitle.numberOfLines = 0

    container.axis = .horizontal
    container.distribution = .fill
    container.spacing = 15
    container.alignment = .center
    container.addArrangedSubview(resultTypeImage)
    container.addArrangedSubview(resultTitle)

    contentView.addSubview(container)
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: contentView.topAnchor),
      container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      resultTypeImage.widthAnchor.constraint(equalToConstant: 70),
      resultTypeImage.heightAnchor.constraint(equalTo: resultTypeImage.widthAnchor)
    ])
  }

  override init(frame: CGRect) {
    resultTitle = UILabel()
    resultTypeImage = UIImageView()
    container = UIStackView()
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
