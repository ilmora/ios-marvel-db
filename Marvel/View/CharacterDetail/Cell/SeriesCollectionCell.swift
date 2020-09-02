//
// Created by Tristan Djahel on 02/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SeriesCollectionCell: UICollectionViewCell {
  let thumbnail: UIImageView
  let title: UILabel
  private let container: UIStackView

  required init?(coder: NSCoder) {
    fatalError()
  }

  private func layoutComponents() {
    container.translatesAutoresizingMaskIntoConstraints = false
    container.axis = .vertical
    container.distribution = .fill
    container.alignment = .fill

    title.numberOfLines = 0

    container.addArrangedSubview(thumbnail)
    container.addArrangedSubview(title)

    contentView.addSubview(container)
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: contentView.topAnchor),
      container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }

  override init(frame: CGRect) {
    thumbnail = UIImageView()
    title = UILabel()
    container = UIStackView()
    super.init(frame: frame)
    layoutComponents()
  }
}
