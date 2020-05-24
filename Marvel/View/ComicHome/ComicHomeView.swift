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

class ComicHomeView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

  private let viewModel: ComicHomeViewModel
  private let collectionView: UICollectionView
  private var comicPubHandle: AnyCancellable?
  private var comicFilterHandle: AnyCancellable?

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.selectedComic = viewModel.comics[indexPath.row]
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.comics.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath)
    -> UICollectionReusableView {
      guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: MagazineLayout.SupplementaryViewKind.sectionHeader, withReuseIdentifier: ComicCollectionHeaderCell.reusableIdentifier, for: indexPath) as? ComicCollectionHeaderCell else {
        fatalError()
      }
      if cell.viewModel == nil {
        cell.viewModel = viewModel
      }
      return cell
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionCell.reusableIdentifier, for: indexPath)
      as? ComicCollectionCell else {
        fatalError("Cell ComicCell was not registered")
    }
    if indexPath.row < viewModel.comics.count {
      cell.configureCell(with: viewModel.comics[indexPath.row])
    }
    return cell
  }

  func setupView() {
    backgroundColor = AppConstants.comicBackgroundColor
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(ComicCollectionCell.self, forCellWithReuseIdentifier: ComicCollectionCell.reusableIdentifier)
    collectionView.register(ComicCollectionHeaderCell.self, forSupplementaryViewOfKind: MagazineLayout.SupplementaryViewKind.sectionHeader, withReuseIdentifier: ComicCollectionHeaderCell.reusableIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false

    comicPubHandle = viewModel.$comics.sink(receiveCompletion: { _ in
      self.comicPubHandle = nil
    }, receiveValue: { _ in
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    })

    addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  init(_ viewModel: ComicHomeViewModel) {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: MagazineLayout())
    self.viewModel = viewModel
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
