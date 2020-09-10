//
//  SearchResultFooterView.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchResultFooterView: UICollectionReusableView {
  var seeMoreButton: SeeMoreButton

  private func setupView() {
    seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(seeMoreButton)
    NSLayoutConstraint.activate([
      seeMoreButton.topAnchor.constraint(equalTo: topAnchor),
      seeMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      seeMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  override init(frame: CGRect) {
    seeMoreButton = SeeMoreButton()
    super.init(frame: frame)
    setupView()
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
}
