//
// Created by Tristan Djahel on 02/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CharacterDetailDataSourceController: NSObject, UICollectionViewDataSource {
  private let character: Character

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    character.series?.items?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionCell.reusableIdentifier, for: indexPath) as? SeriesCollectionCell else {
      fatalError()
    }
    cell.title.text = character.series?.items?[indexPath.row].name ?? ""
    return cell
  }

  init(character: Character) {
    self.character = character
    super.init()
  }
}