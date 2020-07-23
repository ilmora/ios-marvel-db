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
  let seeMoreButton: UIButton

  private func setupView() {
    seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
    seeMoreButton.setTitle("SeeMore".localized, for: .normal)
    seeMoreButton.setTitleColor(.systemGray, for: .normal)
    seeMoreButton.backgroundColor = .clear
    seeMoreButton.layer.borderColor = UIColor.systemGray3.cgColor
    seeMoreButton.layer.borderWidth = 2
    seeMoreButton.layer.cornerRadius = 10
    addSubview(seeMoreButton)
    NSLayoutConstraint.activate([
      seeMoreButton.topAnchor.constraint(equalTo: topAnchor),
      seeMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      seeMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  override init(frame: CGRect) {
    seeMoreButton = UIButton()
    super.init(frame: frame)
    setupView()
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
}
