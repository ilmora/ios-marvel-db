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

  enum SectionTitles: Int {
    case Comics = 0
    case Characters
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedRow = indexPath
  }

  private func setupView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.reusableIdentifier)
    collectionView.register(SearchResultHeaderView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SearchResultHeaderView.reusableIdentifier)
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
    let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)),
                                                 subitem: item, count: 1)
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      section.boundarySupplementaryItems = [headerItem]
      return section
    }
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
