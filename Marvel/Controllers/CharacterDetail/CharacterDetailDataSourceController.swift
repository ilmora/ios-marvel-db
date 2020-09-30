//
// Created by Tristan Djahel on 02/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Combine

class CharacterDetailDataSourceController: NSObject, UICollectionViewDataSource {
  private let character: Character
  private let api: MarvelAPI
  private var seriesHandle: AnyCancellable?
  @Published private(set) var series: [Series]

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    character.series?.items?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionCell.reusableIdentifier, for: indexPath)
      as? SeriesCollectionCell else {
      fatalError()
    }
    guard indexPath.row < series.count - 1 else {
      return cell
    }
    cell.title.text = series[indexPath.row].title ?? ""
    if indexPath.row < series.count {
      cell.setThumbnailImage(with: series[indexPath.row].thumbnail.url)
    } else {
      cell.setThumbnailImage(with: Image.imageNotFound.url)
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeriesHeaderCollectionCell.reusableIdentifier, for: indexPath) as? SeriesHeaderCollectionCell else {
        fatalError()
      }
      headerCell.titleLabel.text = "Apparait dans"
      return headerCell
    default:
      fatalError()
    }
  }

  func fetchSeries() {
    seriesHandle = api.fetchSeries(from: character).sink(receiveCompletion: { error in
      switch error {
      case .failure(let error):
        print(error)
        self.series = [Series]()
      default:
        return
      }
    }, receiveValue: { series in
      self.series = series.sorted { $0.title ?? "" < $1.title ?? "" }
    })
  }

  init(character: Character) {
    self.character = character
    api = MarvelAPI()
    series = [Series]()
    super.init()
  }
}
