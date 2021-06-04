//
//  CharactersListView.swift
//  Marvel
//
//  Created by Tristan Djahel on 02/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class SearchResultView: UIView, UICollectionViewDelegate {
  let collectionView: UICollectionView

  @Published private(set) var selectedRow: IndexPath?

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedRow = indexPath
  }

  private func setupView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(SearchResultCharacterCell.self, forCellWithReuseIdentifier: SearchResultCharacterCell.reusableIdentifier)
    collectionView.register(SearchResultComicCell.self, forCellWithReuseIdentifier: SearchResultComicCell.reusableIdentifier)
    collectionView.register(SearchResultHeaderView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SearchResultHeaderView.reusableIdentifier)
    collectionView.register(SearchResultFooterView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                            withReuseIdentifier: SearchResultFooterView.reusableIdentifier)
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  init() {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      headerItem.pinToVisibleBounds = true
      let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let group:  NSCollectionLayoutGroup
      if sectionIndex == 0 {
        group = NSCollectionLayoutGroup.vertical(
          layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(75)),
          subitem: item, count: 1)
      } else if sectionIndex == 1 {
        group = NSCollectionLayoutGroup.vertical(
          layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(120)),
          subitem: item, count: 1)
      } else {
        fatalError()
      }
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      section.boundarySupplementaryItems = [headerItem, footerItem]
      return section
    }
    let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
    layoutConfiguration.interSectionSpacing = 50
    layout.configuration = layoutConfiguration
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
