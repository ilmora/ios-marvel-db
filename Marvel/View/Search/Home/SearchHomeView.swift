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
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(50), heightDimension: .fractionalHeight(1.0)), subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
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
