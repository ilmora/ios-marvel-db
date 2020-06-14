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
import MagazineLayout

class ComicHomeView: UIView, UICollectionViewDelegate {
  let collectionView: UICollectionView
  @Published private(set) var selectedCellIndex: IndexPath?

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedCellIndex = indexPath
  }

  func setupView() {
    backgroundColor = AppConstants.comicBackgroundColor
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(ComicCollectionCell.self, forCellWithReuseIdentifier: ComicCollectionCell.reusableIdentifier)
    collectionView.register(ComicCollectionHeaderCell.self, forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionHeader, withReuseIdentifier: ComicCollectionHeaderCell.reusableIdentifier)
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
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: MagazineLayout())
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
