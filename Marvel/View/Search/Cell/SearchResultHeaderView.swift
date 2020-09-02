//
//  SearchResultHeaderView.swift
//  Marvel
//
//  Created by Tristan Djahel on 22/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchResultHeaderView: UICollectionReusableView {
  let sectionTitle: UILabel

  private func setupView() {
    sectionTitle.translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
    sectionTitle.textColor = .label
    sectionTitle.font = AppConstants.headerSearchResultFont
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
