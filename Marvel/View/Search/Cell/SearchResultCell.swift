//
//  SearchResultCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {
  let resultTitle: UILabel

  private func setupView() {
    resultTitle.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(resultTitle)
    NSLayoutConstraint.activate([
      resultTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
      resultTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      resultTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      resultTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    resultTitle = UILabel()
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
