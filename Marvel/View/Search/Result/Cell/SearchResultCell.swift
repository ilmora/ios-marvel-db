//
//  SearchResultCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UICollectionViewCell {
  let resultTitle: UILabel
  let resultTypeImage: UIImageView
  private let container: UIStackView

  private let resultTypeImageRatioEqual: NSLayoutConstraint
  private let resultTypeImageRatioBook: NSLayoutConstraint

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

      resultTypeImage.widthAnchor.constraint(lessThanOrEqualToConstant: 75)
    ])
  }

  func setImageRatio(_ multiplier: Float) {
    if multiplier == 1.0 {
      resultTypeImageRatioBook.isActive = false
      resultTypeImageRatioEqual.isActive = true
    } else if multiplier == 1.5 {
      resultTypeImageRatioBook.isActive = true
      resultTypeImageRatioEqual.isActive = false
    }
  }

  override init(frame: CGRect) {
    resultTitle = UILabel()
    resultTypeImage = UIImageView()
    container = UIStackView()
    resultTypeImageRatioBook = resultTypeImage.heightAnchor.constraint(equalTo: resultTypeImage.widthAnchor, multiplier: 1.5)
    resultTypeImageRatioEqual = resultTypeImage.heightAnchor.constraint(equalTo: resultTypeImage.widthAnchor, multiplier: 1)
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
