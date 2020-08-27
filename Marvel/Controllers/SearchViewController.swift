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
  private var searchHandle: AnyCancellable?
  private var selectedRowHandle: AnyCancellable?
  private let searchBarResultDataSource: SearchResultDataSourceController

  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarController.searchResultsUpdater = searchBarResultDataSource
    searchBarController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchBarController
    navigationItem.title = "search".localized

    searchResultView.collectionView.dataSource = searchBarResultDataSource
    searchHandle = searchBarResultDataSource.$comics
      .zip(searchBarResultDataSource.$characters)
      .sink(receiveValue: { _ in
        DispatchQueue.main.async {
          self.searchResultView.collectionView.reloadData()
        }
      })

    selectedRowHandle = searchResultView.$selectedRow.sink(receiveValue: { selectedRow in
      guard let selectedRow = selectedRow,
        let sectionCase = SearchEntitiesSectionTitles(rawValue: selectedRow.section) else {
        return
      }
      switch sectionCase {
      case .Comics:
        let comic = self.searchBarResultDataSource.comics[selectedRow.row]
        self.navigationController?.pushViewController(ComicDetailViewController(comic), animated: true)
      case .Characters:
        let character = self.searchBarResultDataSource.characters[selectedRow.row]
        self.navigationController?.pushViewController(CharacterDetailViewController(character: character), animated: true)
      }
    })
  }

  private func reloadCollectionView() {
    DispatchQueue.main.async {
      self.searchResultView.collectionView.reloadData()
    }
  }

  override func loadView() {
    view = searchResultView
  }

  init() {
    searchResultView = SearchResultView()
    searchBarResultDataSource = SearchResultDataSourceController()
    searchBarController = UISearchController(searchResultsController: nil)
    super.init(nibName: nil, bundle: nil)
    searchBarResultDataSource.didPressSeeMoreButtonHandler = reloadCollectionView
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
