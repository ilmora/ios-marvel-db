//
//  SearchResultDataSourceController.swift
//  Marvel
//
//  Created by Tristan Djahel on 04/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class SearchResultDataSourceController: NSObject, UISearchResultsUpdating, UITableViewDataSource {

  // MARK: Data

  private let api = MarvelAPI()

  @Published private var inputSearchText: String?
  private var textInputHandle: AnyCancellable?

  @Published private(set) var comics = [Comic]()
  private var comicsHandle: AnyCancellable?

  @Published private(set) var characters = [Character]()
  private var charactersHandle: AnyCancellable?

  // MARK: Events

  func updateSearchResults(for searchController: UISearchController) {
    if textInputHandle == nil {
      textInputHandle = $inputSearchText
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .sink(receiveValue: fetchResultFromApi)
    }
    inputSearchText = searchController.searchBar.text
  }

  func fetchResultFromApi(_ newSearchValue: String?) {
    guard let newSearchValue = newSearchValue else {
      comics = [Comic]()
      characters = [Character]()
      return
    }
    let (comicPublisher, characterPublisher) = api.fetchEntities(containing: newSearchValue)
    comicsHandle = comicPublisher.sink(receiveCompletion: { _ in
      self.comicsHandle = nil
    }, receiveValue: { comics in
      self.comics = comics
    })
    charactersHandle = characterPublisher.sink(receiveCompletion: { _ in
      self.charactersHandle = nil
    }, receiveValue: { characters in
      self.characters = characters
    })
  }

  // MARK: TableView Data source

  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return comics.count
    case 1:
      return characters.count
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reusableIdentifier, for: indexPath)
      as? SearchResultCell else {
        fatalError()
    }
    let resultTitleText: String?
    switch indexPath.section {
    case 0:
      resultTitleText = comics[indexPath.row].title
    case 1:
      resultTitleText = characters[indexPath.row].name
    default:
      fatalError()
    }
    cell.resultTitle.text = resultTitleText
    return cell
  }
}
