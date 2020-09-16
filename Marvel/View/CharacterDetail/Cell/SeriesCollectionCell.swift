//
// Created by Tristan Djahel on 02/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SeriesCollectionCell: UICollectionViewCell {
  private let thumbnail: UIImageView
  let title: UILabel

  required init?(coder: NSCoder) {
    fatalError()
  }

  func setThumbnailImage(with url: URL) {
    thumbnail.kf.setImage(with: url, options: [.processor(OverlayImageProcessor(overlay: .systemBackground, fraction: 0.5))])
  }

  private func layoutComponents() {
    thumbnail.translatesAutoresizingMaskIntoConstraints = false
    title.translatesAutoresizingMaskIntoConstraints = false

    title.numberOfLines = 0
    title.textColor = .label

    contentView.addSubview(thumbnail)
    contentView.addSubview(title)

    NSLayoutConstraint.activate([
      thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor),
      thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      thumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      title.topAnchor.constraint(equalTo: contentView.topAnchor),
      title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }

  override init(frame: CGRect) {
    thumbnail = UIImageView()
    title = UILabel()
    super.init(frame: frame)
    layoutComponents()
  }
}
