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
  private let searchResultView: SearchResultView
  private let searchBarController: UISearchController

  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarController.searchResultsUpdater = searchBarResultDataSource
    searchBarController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchBarController
    navigationItem.title = "search".localized
  }

  override func loadView() {
    view = searchResultView
  }

  init() {
    searchResultView = SearchResultView()
    searchBarController = UISearchController(searchResultsController: nil)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
