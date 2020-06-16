//
//  ComicDetailView.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Combine

class ComicDetailView: UIView {
  private let scrollView: UIScrollView
  private let container: UIStackView

  let titleLabel: UILabel
  let publishedDateLabel: UILabel
  var creatorsLabel: UILabel
  let coverImage: UIImageView

  private func setupView() {

    backgroundColor = AppConstants.comicBackgroundColor

    scrollView.translatesAutoresizingMaskIntoConstraints = false
    coverImage.translatesAutoresizingMaskIntoConstraints = false
    container.translatesAutoresizingMaskIntoConstraints = false

    container.axis = .vertical
    container.alignment = .fill
    container.spacing = 40

    coverImage.layer.shadowColor = UIColor.black.cgColor
    coverImage.layer.shadowOffset = CGSize(width: 0, height: 0)
    coverImage.layer.shadowRadius = 3
    coverImage.layer.shadowOpacity = 1

    scrollView.showsVerticalScrollIndicator = false

    titleLabel.numberOfLines = 0
    titleLabel.font = AppConstants.comicLargeTitle

    creatorsLabel.numberOfLines = 0

    container.addArrangedSubview(titleLabel)
    container.addArrangedSubview(coverImage)
    container.addArrangedSubview(publishedDateLabel)
    container.addArrangedSubview(creatorsLabel)
    scrollView.addSubview(container)
    addSubview(scrollView)

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

      coverImage.widthAnchor.constraint(equalTo: container.widthAnchor),
      coverImage.heightAnchor.constraint(equalTo: coverImage.widthAnchor, multiplier: 1.5),
    ])
  }

  init() {
    coverImage = UIImageView()
    container = UIStackView()
    titleLabel = UILabel()
    scrollView = UIScrollView()
    publishedDateLabel = UILabel()
    creatorsLabel = UILabel()
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
