//
//  ComicDataSourceController.swift
//  Marvel
//
//  Created by Tristan Djahel on 13/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ComicDataSourceController: NSObject {
  @Published private(set) var newComics: [Comic]
  @Published private(set) var futureComics: [Comic]
  private let marvelApi = MarvelAPI()
  private var fetchComicsHandle: AnyCancellable?

  private let collectionView: UICollectionView

  func makeSnapshot() -> NSDiffableDataSourceSnapshot<ComicFilterCase, Comic> {
    var snapshot = NSDiffableDataSourceSnapshot<ComicFilterCase, Comic>()
    snapshot.appendSections([comicsTypeDisplayed])
    snapshot.appendItems(getComicsFromFilter(), toSection: comicsTypeDisplayed)
    return snapshot
  }

  func makeDataSource() -> UICollectionViewDiffableDataSource<ComicFilterCase, Comic> {
    let dataSource = UICollectionViewDiffableDataSource<ComicFilterCase, Comic>(collectionView: collectionView, cellProvider: { collectionView, indexPath, comic in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionCell.reusableIdentifier, for: indexPath)
              as? ComicCollectionCell else {
        fatalError("Cell ComicCell was not registered")
      }
      let comic = self.getComicsFromFilter()[indexPath.row]
      cell.titleLabel.text = comic.title
      if let comicImage = comic.thumbnail {
        let imageURL = URL(string: "\(comicImage.path!).\(comicImage.extension!)")!
        cell.coverImage.kf.setImage(with: imageURL)
      }
      return cell
    })
    return dataSource
  }

  var comicsTypeDisplayed: ComicFilterCase = .New

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

  func getComicsFromFilter() -> [Comic] {
    switch comicsTypeDisplayed {
    case .New:
      return newComics
    case .Future:
      return futureComics
    }
  }

  init(_ collectionView: UICollectionView) {
    newComics = [Comic]()
    futureComics = [Comic]()
    self.collectionView = collectionView
    super.init()
  }
}
