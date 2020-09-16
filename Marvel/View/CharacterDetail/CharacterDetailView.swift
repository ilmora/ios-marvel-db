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
  let descriptionLabel: UILabel
  let collectionView: UICollectionView
  let nameLabel: UILabel

  func setThumbnailImage(_ url: URL?) {
    thumbnail.kf.setImage(with: url, options: [.processor(RoundCornerImageProcessor(cornerRadius: 20))])
  }

  private func setupView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    container.translatesAutoresizingMaskIntoConstraints = false
    thumbnail.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    nameLabel.font = AppConstants.largeTitle
    descriptionLabel.font = AppConstants.body
    descriptionLabel.textColor = .label
    descriptionLabel.numberOfLines = 0

    addSubview(scrollView)

    scrollView.addSubview(container)
    scrollView.backgroundColor = AppConstants.backgroundColor

    collectionView.backgroundColor = .clear

    container.axis = .vertical
    container.alignment = .center
    container.distribution = .fill
    container.spacing = 20
    container.addArrangedSubview(thumbnail)
    container.addArrangedSubview(nameLabel)
    container.addArrangedSubview(descriptionLabel)
    container.addArrangedSubview(collectionView)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      container.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
      container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
      container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 10),
      container.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
      container.centerXAnchor.constraint(equalTo: centerXAnchor),
      container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

      nameLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 35),

      thumbnail.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
      thumbnail.heightAnchor.constraint(equalTo: thumbnail.widthAnchor, multiplier: 1),

      collectionView.widthAnchor.constraint(equalTo: container.widthAnchor),
      collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
    ])
  }

  init() {
    scrollView = UIScrollView()
    container = UIStackView()
    thumbnail = UIImageView()
    nameLabel = UILabel()
    let layout = UICollectionViewCompositionalLayout {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
      group.interItemSpacing = .fixed(10)
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      section.boundarySupplementaryItems = [headerItem]
      return section
    }
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    descriptionLabel = UILabel()
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
