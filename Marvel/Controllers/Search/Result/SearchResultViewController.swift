//
//  SearchResultViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class SearchResultViewController: UIViewController, UISearchResultsUpdating {
  private let searchResultView: SearchResultView
  private let searchBarResultDataSource: SearchResultDataSourceController
  private var selectedRowHandle: AnyCancellable?
  private var searchHandle: AnyCancellable?
  private var userInputTimer: Timer?
  var previousViewController: UIViewController?

  func updateSearchResults(for searchController: UISearchController) {
    guard let userInput = searchController.searchBar.text, userInput != "" else {
      return
    }
    userInputTimer?.invalidate()
    userInputTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
      self.searchBarResultDataSource.fetchResultFromApi(userInput)
      var userSearchHistory = Cache.userSearchHistory
      userSearchHistory.insert(userInput, at: 0)
      Cache.userSearchHistory = userSearchHistory
    }
  }

  override func loadView() {
    view = searchResultView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    searchResultView.collectionView.dataSource = searchBarResultDataSource
    searchHandle = searchBarResultDataSource.$comics
      .combineLatest(searchBarResultDataSource.$characters)
      .sink(receiveValue: { _ in
        self.reloadCollectionView()
      })

    selectedRowHandle = searchResultView.$selectedRow.sink(receiveValue: { selectedRow in
      guard let selectedRow = selectedRow,
        let sectionCase = SearchEntitiesSection(rawValue: selectedRow.section) else {
          return
      }
      switch sectionCase {
      case .Comics:
        let comic = self.searchBarResultDataSource.comics[selectedRow.row]
        self.previousViewController?.navigationController?.pushViewController(ComicDetailViewController(comic), animated: true)
      case .Characters:
        let character = self.searchBarResultDataSource.characters[selectedRow.row]
        self.previousViewController?.navigationController?.pushViewController(CharacterDetailViewController(character: character), animated: true)
      }
    })
  }

  private func reloadCollectionView() {
    DispatchQueue.main.async {
      self.searchResultView.collectionView.reloadData()
    }
  }

  init() {
    searchResultView = SearchResultView()
    searchBarResultDataSource = SearchResultDataSourceController()
    super.init(nibName: nil, bundle: nil)
    searchBarResultDataSource.didPressSeeMoreButtonHandler = reloadCollectionView
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
