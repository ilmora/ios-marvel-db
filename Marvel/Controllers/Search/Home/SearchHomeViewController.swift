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

  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarController.searchBar.sizeToFit()
    searchBarController.searchResultsUpdater = searchResultViewController
    searchBarController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchBarController
    navigationItem.title = "search".localized
    searchHomeView.historicUserInputCollectionView.dataSource = searchUserInputDataSource
    searchHomeView.historicUserInputCollectionView.register(SearchUserInputCell.self, forCellWithReuseIdentifier: SearchUserInputCell.reusableIdentifier)
    DispatchQueue.main.async {
      self.searchHomeView.historicUserInputCollectionView.reloadData()
    }
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
