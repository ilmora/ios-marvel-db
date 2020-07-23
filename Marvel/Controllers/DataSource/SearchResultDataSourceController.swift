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

// MARK: CollectionView Data source
extension SearchResultDataSourceController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionCase = SearchResultView.SectionTitles(rawValue: section) else {
      return 0
    }
    switch sectionCase {
    case .Comics:
      return min(comics.count, 2)
    case .Characters:
      return min(characters.count, 2)
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultHeaderView.reusableIdentifier, for: indexPath)
        as? SearchResultHeaderView,
      let sectionCase = SearchResultView.SectionTitles(rawValue: indexPath.section) else {
          fatalError()
      }
      switch sectionCase {
      case .Comics:
        headerCell.sectionTitle.text = "Comic".localized
      case .Characters:
        headerCell.sectionTitle.text = "Characters".localized
      }
      return headerCell
    default:
      fatalError()
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.reusableIdentifier, for: indexPath)
      as? SearchResultCell else {
        fatalError()
    }
    guard let sectionCase = SearchResultView.SectionTitles(rawValue: indexPath.section) else {
      fatalError()
    }
    switch sectionCase {
    case .Comics:
      let comic = comics[indexPath.row]
      cell.resultTitle.text = comic.title
      cell.setImageRatio(1.5)
      if let thumbnail = comic.thumbnail {
        cell.resultTypeImage.kf.setImage(with: getImageUrl(of: thumbnail))
      } else {
        cell.resultTypeImage.image = UIImage(systemName: "book.fill")
      }
    case .Characters:
      let character = characters[indexPath.row]
      cell.resultTitle.text = character.name
      cell.setImageRatio(1.0)
      if let thumbnail = character.thumbnail {
        cell.resultTypeImage.kf.setImage(with: getImageUrl(of: thumbnail))
      } else {
        cell.resultTypeImage.image = UIImage(systemName: "person.fill")
      }
    }
    return cell
  }


  private func getImageUrl(of image: Image) -> URL {
    URL(string: "\(image.path!).\(image.extension!)")!
  }

  func numberOfSections(in: UICollectionView) -> Int {
    var nbOfSections = 0
    if comics.first != nil {
      nbOfSections += 1
    }
    if characters.first != nil {
      nbOfSections += 1
    }
    return nbOfSections
  }
}
