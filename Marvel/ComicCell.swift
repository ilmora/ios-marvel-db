//
//  ComicCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
  let titleLabel: UILabel

  required init?(coder: NSCoder) {
    fatalError()
  }

  override init(frame: CGRect) {
    titleLabel = UILabel()
    titleLabel.textColor = .purple
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    super.init(frame: frame)
    backgroundColor = .white
    contentView.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
