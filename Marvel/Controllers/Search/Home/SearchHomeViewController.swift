//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 26/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class SearchHomeViewController: UIViewController {
  private let searchHomeView: SearchHomeView
  private let searchBarController: UISearchController
  private let searchResultViewController: SearchResultViewController
  private let searchUserInputDataSource: SearchHomeDataSourceController

  private lazy var dataSource = searchUserInputDataSource.makeDataSource()
  private lazy var snapshot = searchUserInputDataSource.makeSnapshot()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.hidesSearchBarWhenScrolling = false
    searchBarController.searchResultsUpdater = searchResultViewController
    searchBarController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchBarController
    navigationItem.title = "search".localized
    searchUserInputDataSource.collectionView = searchHomeView.historicUserInputCollectionView
    searchHomeView.historicUserInputCollectionView.register(SearchUserInputCell.self, forCellWithReuseIdentifier: SearchUserInputCell.reusableIdentifier)
    searchHomeView.historicUserInputCollectionView.register(SearchHomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHomeHeaderView.reusableIdentifier)
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  override func loadView() {
    view = searchHomeView
  }

  init() {
    searchHomeView = SearchHomeView()
    searchResultViewController = SearchResultViewController()
    searchUserInputDataSource = SearchHomeDataSourceController()
    searchBarController = UISearchController(searchResultsController: searchResultViewController)
    super.init(nibName: nil, bundle: nil)
    searchResultViewController.previousViewController = self
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
