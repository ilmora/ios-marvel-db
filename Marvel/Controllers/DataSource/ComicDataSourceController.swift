//
//  ComicDataSourceController.swift
//  Marvel
//
//  Created by Tristan Djahel on 13/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import MagazineLayout
import Combine

class ComicDataSourceController: NSObject, UICollectionViewDataSource {
  @Published private(set) var newComics: [Comic]
  @Published private(set) var futureComics: [Comic]
  private let marvelApi = MarvelAPI()
  private var fetchComicsHandle: AnyCancellable?

  func fetchData() {
    fetchComicsHandle = marvelApi.fetchAboutToBePublishedComics()
      .zip(marvelApi.fetchNewlyPublishedComics())
      .sink(receiveCompletion: { error in
      print(error)
    }, receiveValue: { (futureComics, newComics) in
      self.futureComics = futureComics
      self.newComics = newComics
    })
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
      case AppConstants.ComicSection.newComics:
        cell.title.text = "comics_new".localized
      case AppConstants.ComicSection.futureComics:
        cell.title.text = "comics_to_come".localized
      default:
        fatalError()
      }
      return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case AppConstants.ComicSection.newComics:
      return newComics.count
    case AppConstants.ComicSection.futureComics:
      return futureComics.count
    default:
      fatalError()
    }
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    var count = 1
    if futureComics.first != nil {
      count += 1
    }
    return count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionCell.reusableIdentifier, for: indexPath)
      as? ComicCollectionCell else {
        fatalError("Cell ComicCell was not registered")
    }
    let comic: Comic
    switch indexPath.section {
    case AppConstants.ComicSection.newComics:
      comic = newComics[indexPath.row]
    case AppConstants.ComicSection.futureComics:
      comic = futureComics[indexPath.row]
    default:
      fatalError()
    }
    cell.titleLabel.text = comic.title
    if let comicImage = comic.thumbnail {
      let imageURL = URL(string: "\(comicImage.path!).\(comicImage.extension!)")!
      cell.coverImage.kf.setImage(with: imageURL)
    }
    return cell
  }

  override init() {
    newComics = [Comic]()
    futureComics = [Comic]()
    super.init()
  }
}
