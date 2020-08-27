//
//  ComicHomeView.swift
//  Marvel
//
//  Created by Tristan Djahel on 19/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ComicHomeView: UIView, UICollectionViewDelegate {
  let collectionView: UICollectionView
  @Published private(set) var selectedCellIndex: IndexPath?

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedCellIndex = indexPath
  }

  func setupView() {
    backgroundColor = AppConstants.backgroundColor
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(ComicCollectionCell.self, forCellWithReuseIdentifier: ComicCollectionCell.reusableIdentifier)
    collectionView.delegate = self
    collectionView.showsVerticalScrollIndicator = false

    addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  init() {
    let estimatedHeight: NSCollectionLayoutDimension = .estimated(UIScreen.main.bounds.height / 2)
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: estimatedHeight))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: estimatedHeight), subitem: item, count: 2)
    group.interItemSpacing = .fixed(10)
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 40
    section.contentInsets = .init(top: 20, leading: 10, bottom: 0, trailing: 10)
    let layout = UICollectionViewCompositionalLayout(section: section)
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
