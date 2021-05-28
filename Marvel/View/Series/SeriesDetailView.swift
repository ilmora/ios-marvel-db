//
// Created by Tristan Djahel on 16/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SeriesDetailView: UIView {
  let titleLabel: UILabel
  private let scrollView: UIScrollView
  private let container: UIStackView
  private let thumbnail: UIImageView
  private let charactersCollectionView: UICollectionView

  func setThumbnailImage(_ url: URL) {
    thumbnail.kf.setImage(with: url)
  }

  private func setupView() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    container.translatesAutoresizingMaskIntoConstraints = false
    thumbnail.translatesAutoresizingMaskIntoConstraints = false

    backgroundColor = AppConstants.backgroundColor

    titleLabel.textColor = .label
    titleLabel.font = AppConstants.largeTitle

    container.axis = .vertical
    container.alignment = .center
    container.distribution = .fill

    addSubview(scrollView)

    scrollView.addSubview(container)
    scrollView.backgroundColor = AppConstants.backgroundColor

    container.addArrangedSubview(titleLabel)
    container.addArrangedSubview(thumbnail)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      container.topAnchor.constraint(equalTo: scrollView.topAnchor),
      container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      container.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

      thumbnail.widthAnchor.constraint(equalTo: container.widthAnchor),
      thumbnail.heightAnchor.constraint(equalTo: thumbnail.widthAnchor)
    ])
  }

  init() {
    titleLabel = UILabel()
    scrollView = UIScrollView()
    container = UIStackView()
    thumbnail = UIImageView()
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment ) -> NSCollectionLayoutSection? in
      let itemLayout = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [itemLayout])
      group.interItemSpacing = .fixed(10)
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      return section
    }
    charactersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
