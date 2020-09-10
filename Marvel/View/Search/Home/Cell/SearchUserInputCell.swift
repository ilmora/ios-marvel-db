//
//  SearchUserInputCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchUserInputCell: UICollectionViewCell {
  let userInputLabel: UILabel

  private func layoutComponents() {
    userInputLabel.translatesAutoresizingMaskIntoConstraints = false
    userInputLabel.font = AppConstants.body
    contentView.addSubview(userInputLabel)
    NSLayoutConstraint.activate([
      userInputLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      userInputLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      userInputLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      userInputLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }

  override init(frame: CGRect) {
    userInputLabel = UILabel()
    super.init(frame: frame)
    layoutComponents()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
