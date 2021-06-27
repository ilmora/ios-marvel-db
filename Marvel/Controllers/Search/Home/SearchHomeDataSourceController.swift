//
//  SearchHomeDataSourceController.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeDataSourceController: NSObject {

  var collectionView: UICollectionView?

  func makeDataSource() -> UICollectionViewDiffableDataSource<SearchUserHistorySection, String> {
    let dataSource = UICollectionViewDiffableDataSource<SearchUserHistorySection, String>(
      collectionView: collectionView!,
      cellProvider: { collectionView, indexPath, userSearchHistory in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchUserInputCell.reusableIdentifier, for: indexPath)
        as? SearchUserInputCell else {
          fatalError()
        }
        cell.userInputLabel.text = userSearchHistory
        return cell
    })

    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
      switch kind {
      case UICollectionView.elementKindSectionHeader:
        guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHomeHeaderView.reusableIdentifier, for: indexPath) as? SearchHomeHeaderView else {
          fatalError()
        }
        headerCell.sectionTitle.text = "LastResearch".localized
        return headerCell
      default:
        fatalError()
      }
    }
    return dataSource
  }

  func makeSnapshot() -> NSDiffableDataSourceSnapshot<SearchUserHistorySection, String> {
    var snapshot = NSDiffableDataSourceSnapshot<SearchUserHistorySection, String>()
    snapshot.appendSections([SearchUserHistorySection.main])
    snapshot.appendItems(Cache.userSearchHistory, toSection: .main)
    return snapshot
  }
}
