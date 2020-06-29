//
//  ComicCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ComicCollectionCell: UICollectionViewCell {
  let coverImage: UIImageView
  let titleLabel: UILabel
  private let container: UIStackView

  private func layoutComponents() {
    container.translatesAutoresizingMaskIntoConstraints = false
    coverImage.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    container.axis = .vertical
    container.alignment = .fill
    container.distribution = .fill

    contentView.backgroundColor = AppConstants.comicBackgroundColor
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .natural
    titleLabel.font = AppConstants.comicTitle

    container.addArrangedSubview(coverImage)
    container.addArrangedSubview(titleLabel)
    container.setCustomSpacing(15, after: coverImage)
    contentView.addSubview(container)

    if traitCollection.userInterfaceStyle == .light {
      coverImage.layer.shadowColor = UIColor.label.cgColor
      coverImage.layer.shadowOffset = CGSize(width: 0, height: 0)
      coverImage.layer.shadowRadius = 3
      coverImage.layer.shadowOpacity = 1
    }

    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: contentView.topAnchor),
      container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      coverImage.heightAnchor.constraint(equalTo: coverImage.widthAnchor, multiplier: 1.5),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override init(frame: CGRect) {
    coverImage = UIImageView()
    titleLabel = UILabel()
    container = UIStackView()
    super.init(frame: frame)
    layoutComponents()
    backgroundColor = .white
  }
}
