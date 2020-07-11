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
import Kingfisher

class SearchResultDataSourceController: NSObject, UISearchResultsUpdating {
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

  private func fetchResultFromApi(_ newSearchValue: String?) {
    guard let newSearchValue = newSearchValue, newSearchValue != "" else {
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
}

// MARK: TableView Data source
extension SearchResultDataSourceController: UITableViewDataSource {

  private func getImageUrl(of image: Image) -> URL {
    URL(string: "\(image.path!).\(image.extension!)")!
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    comics.count + characters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reusableIdentifier, for: indexPath)
      as? SearchResultCell else {
        fatalError()
    }
    if indexPath.row < comics.count {
      // Comic
      let comic = comics[indexPath.row]
      cell.resultTitle.text = comic.title
      if let thumbnail = comic.thumbnail {
        cell.resultTypeImage.kf.setImage(with: getImageUrl(of: thumbnail))
      } else {
        cell.resultTypeImage.image = UIImage(systemName: "book.fill")
      }
    } else {
      // Personnage
      let character = characters[indexPath.row - comics.count]
      cell.resultTitle.text = character.name
      if let thumbnail = character.thumbnail {
        cell.resultTypeImage.kf.setImage(with: getImageUrl(of: thumbnail),
                                         options: [.processor(RoundCornerImageProcessor(cornerRadius: 2000))])
      } else {
        cell.resultTypeImage.image = UIImage(systemName: "person.fill")
      }
    }
    return cell
  }
}
