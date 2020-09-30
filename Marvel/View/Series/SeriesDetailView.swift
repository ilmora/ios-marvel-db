//
// Created by Tristan Djahel on 16/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SeriesDetailView: UIView {
  let label: UILabel

  private func setupView() {
    label.translatesAutoresizingMaskIntoConstraints = false

    backgroundColor = AppConstants.backgroundColor
    label.textColor = .label
    
    addSubview(label)

    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  init() {
    label = UILabel()
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
