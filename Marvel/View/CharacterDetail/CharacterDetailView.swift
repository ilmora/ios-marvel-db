//
//  CharaterDetailView.swift
//  Marvel
//
//  Created by Tristan Djahel on 15/08/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CharacterDetailView: UIView {
  private let scrollView: UIScrollView
  private let container: UIStackView
  private let thumbnail: UIImageView
  let nameLabel: UILabel

  func setThumbnailImage(_ url: URL?) {
    thumbnail.kf.setImage(with: url, options: [.processor(RoundCornerImageProcessor(cornerRadius: 20))])
  }

  private func setupView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    container.translatesAutoresizingMaskIntoConstraints = false
    thumbnail.translatesAutoresizingMaskIntoConstraints = false

    nameLabel.font = AppConstants.largeTitle

    addSubview(scrollView)
    scrollView.addSubview(container)
    scrollView.backgroundColor = AppConstants.backgroundColor
    container.axis = .vertical
    container.alignment = .center
    container.spacing = 20
    container.addArrangedSubview(thumbnail)
    container.addArrangedSubview(nameLabel)
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      container.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
      container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
      container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 10),
      container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      container.centerXAnchor.constraint(equalTo: centerXAnchor),

      thumbnail.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
      thumbnail.heightAnchor.constraint(equalTo: thumbnail.widthAnchor, multiplier: 1)
    ])
  }

  init() {
    scrollView = UIScrollView()
    container = UIStackView()
    thumbnail = UIImageView()
    nameLabel = UILabel()
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
