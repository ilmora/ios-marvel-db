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

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    newComics.count
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionCell.reusableIdentifier, for: indexPath)
      as? ComicCollectionCell else {
        fatalError("Cell ComicCell was not registered")
    }
    let comic = newComics[indexPath.row]
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
