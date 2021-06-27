//
//  SearchHomeView.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeView: UIView {
  let historicUserInputCollectionView: UICollectionView

  private func layoutComponents() {
    historicUserInputCollectionView.translatesAutoresizingMaskIntoConstraints = false
    historicUserInputCollectionView.backgroundColor = AppConstants.backgroundColor
    historicUserInputCollectionView.isScrollEnabled = true
    addSubview(historicUserInputCollectionView)
    NSLayoutConstraint.activate([
      historicUserInputCollectionView.topAnchor.constraint(equalTo: topAnchor),
      historicUserInputCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      historicUserInputCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      historicUserInputCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  init() {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [item])
      group.interItemSpacing = .fixed(5)
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
      section.boundarySupplementaryItems = [headerItem]
      return section
    }
    historicUserInputCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(frame: .zero)
    layoutComponents()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
