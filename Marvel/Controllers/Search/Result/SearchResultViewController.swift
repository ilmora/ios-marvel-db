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

class SearchResultViewController: UIViewController, UISearchResultsUpdating, UICollectionViewDelegate {
  private let searchResultView: SearchResultView
  private let searchBarResultDataSource: SearchResultDataSourceController
  private var selectedRowHandle: AnyCancellable?
  private var searchHandle: AnyCancellable?
  private var userInputTimer: Timer?
  var previousViewController: UIViewController?

  private lazy var dataSource = searchBarResultDataSource.makeDataSource()

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else {
      return
    }
    switch item {
    case .Characters(let character):
      self.previousViewController?.navigationController?.pushViewController(CharacterDetailViewController(character: character), animated: true)
    case .Comics(let comic):
      self.previousViewController?.navigationController?.pushViewController(ComicDetailViewController(comic), animated: true)
    }
  }

  func updateSearchResults(for searchController: UISearchController) {
    guard let userInput = searchController.searchBar.text, userInput != "" else {
      return
    }
    userInputTimer?.invalidate()
    userInputTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
      self.searchBarResultDataSource.fetchResultFromApi(userInput)
      var userSearchHistory = Cache.userSearchHistory
      if !Cache.userSearchHistory.contains(userInput) {
        userSearchHistory.insert(userInput, at: 0)
      } else {
        let index = userSearchHistory.firstIndex(of: userInput).unsafelyUnwrapped
        userSearchHistory.swapAt(0, index)
      }
      Cache.userSearchHistory = userSearchHistory
    }
  }

  override func loadView() {
    view = searchResultView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    searchResultView.collectionView.delegate = self
    searchHandle = searchBarResultDataSource.$comics
      .combineLatest(searchBarResultDataSource.$characters)
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { _ in
        self.dataSource.apply(self.searchBarResultDataSource.makeSnapshot(), animatingDifferences: true)
      })
  }

  init() {
    searchResultView = SearchResultView()
    searchBarResultDataSource = SearchResultDataSourceController(searchResultView.collectionView)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
