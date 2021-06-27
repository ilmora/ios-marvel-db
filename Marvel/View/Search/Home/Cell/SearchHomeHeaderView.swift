//
//  SearchHomeHeaderView.swift
//  Marvel
//
//  Created by Tristan Djahel on 27/06/2021.
//  Copyright © 2021 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeHeaderView: UICollectionReusableView {
  let sectionTitle: UILabel

  private func setupView() {
    sectionTitle.translatesAutoresizingMaskIntoConstraints = false
    sectionTitle.font = AppConstants.headerSearchResultFont
    sectionTitle.textColor = .label
    sectionTitle.backgroundColor = .clear

    addSubview(sectionTitle)
    NSLayoutConstraint.activate([
      sectionTitle.topAnchor.constraint(equalTo: topAnchor),
      sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
      sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
      sectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  override init(frame: CGRect) {
    sectionTitle = UILabel()
    super.init(frame: frame)
    setupView()

  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
