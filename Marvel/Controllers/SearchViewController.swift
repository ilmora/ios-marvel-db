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

class SearchViewController: UIViewController {
  private let searchResultView: SearchResultView
  private let searchBarController: UISearchController
  private var charactersHandle: AnyCancellable?
  private var comicsHandle: AnyCancellable?
  private let searchBarResultDataSource: SearchResultDataSourceController

  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarController.searchResultsUpdater = searchBarResultDataSource
    navigationItem.searchController = searchBarController
    navigationItem.title = "search".localized

    searchResultView.tableView.dataSource = searchBarResultDataSource
    charactersHandle = searchBarResultDataSource.$characters.sink(receiveValue: { _ in
      DispatchQueue.main.async {
        self.searchResultView.tableView.reloadData()
      }
    })
    comicsHandle = searchBarResultDataSource.$comics.sink(receiveValue: { _ in
      DispatchQueue.main.async {
        self.searchResultView.tableView.reloadData()
      }
    })
  }

  override func loadView() {
    view = searchResultView
  }

  init() {
    searchResultView = SearchResultView()
    searchBarResultDataSource = SearchResultDataSourceController()
    searchBarController = UISearchController(searchResultsController: nil)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
