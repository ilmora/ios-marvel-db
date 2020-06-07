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
  private var comicPublisherHandle: AnyCancellable?

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.selectedComic = viewModel.newComics[indexPath.row]
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return viewModel.newComics.count
    case 1:
      return viewModel.nextComics.count
    default:
      fatalError()
    }
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    var count = 1
    if viewModel.nextComics.first != nil {
      count += 1
    }
    return count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath)
    -> UICollectionReusableView {
      guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: MagazineLayout.SupplementaryViewKind.sectionHeader, withReuseIdentifier: ComicCollectionHeaderCell.reusableIdentifier, for: indexPath) as? ComicCollectionHeaderCell else {
        fatalError()
      }
      switch indexPath.section {
      case 0:
        cell.setSectionTitle("Nouveau")
      case 1:
        cell.setSectionTitle("Prochainement")
      default:
        fatalError()
      }
      return cell
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionCell.reusableIdentifier, for: indexPath)
      as? ComicCollectionCell else {
        fatalError("Cell ComicCell was not registered")
    }
    switch indexPath.section {
    case 0:
      cell.configureCell(with: viewModel.newComics[indexPath.row])
    case 1:
      cell.configureCell(with: viewModel.nextComics[indexPath.row])
    default:
      fatalError()
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

    comicPublisherHandle = viewModel.$newComics
      .merge(with: viewModel.$nextComics)
      .sink(receiveCompletion: { _ in
      self.comicPublisherHandle = nil
    }, receiveValue: { comics in
      guard comics.first != nil else { return }
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
