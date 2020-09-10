//
//  SearchHomeDataSourceController.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeDataSourceController: NSObject, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    Cache.userSearchHistory.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchUserInputCell.reusableIdentifier, for: indexPath)
      as? SearchUserInputCell else {
        fatalError()
    }

    cell.userInputLabel.text = Cache.userSearchHistory[indexPath.row]
    return cell
  }
}
