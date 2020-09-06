//
//  SeriesHeaderCollectionCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SeriesHeaderCollectionCell: UICollectionViewCell {

  let titleLabel: UILabel

  private func layoutComponents() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    titleLabel.font = AppConstants.title
    titleLabel.textColor = .black

    contentView.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }

  override init(frame: CGRect) {
    titleLabel = UILabel()
    super.init(frame: frame)
    layoutComponents()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
