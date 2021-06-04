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

class SearchResultDataSourceController: NSObject {
  // MARK: Data
  private let api = MarvelAPI()

  @Published private var inputSearchText: String?
  private var textInputHandle: AnyCancellable?

  @Published private(set) var comics = [Comic]()
  private var comicsHandle: AnyCancellable?

  @Published private(set) var characters = [Character]()
  private var charactersHandle: AnyCancellable?

  private var nbComicsToDisplay = 6
  private var nbCharactersToDisplay = 6

  var didPressSeeMoreButtonHandler: (() -> Void)?

  func fetchResultFromApi(_ newSearchValue: String?) {
    guard let newSearchValue = newSearchValue, newSearchValue != "" else {
      comics = [Comic]()
      characters = [Character]()
      nbComicsToDisplay = 6
      nbCharactersToDisplay = 6
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

  @objc private func didPressSeeMoreButton(_ sender: UIButton) {
    guard let targetEntity = (sender as? SeeMoreButton)?.targetEntity else {
      return
    }
    switch targetEntity {
    case .Comics:
      nbComicsToDisplay = comics.count
    case .Characters:
      nbCharactersToDisplay = characters.count
    }
    if let handler = didPressSeeMoreButtonHandler {
      handler()
    }
  }
}

// MARK: CollectionView Data source
extension SearchResultDataSourceController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionCase = SearchEntitiesSection(rawValue: section) else {
      return 0
    }
    switch sectionCase {
    case .Comics:
      return min(comics.count, nbComicsToDisplay)
    case .Characters:
      return min(characters.count, nbCharactersToDisplay)
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let sectionCase = SearchEntitiesSection(rawValue: indexPath.section) else {
      fatalError()
    }
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultHeaderView.reusableIdentifier, for: indexPath)
              as? SearchResultHeaderView else {
        fatalError()
      }
      headerCell.sectionTitle.text = sectionCase.title
      return headerCell
    case UICollectionView.elementKindSectionFooter:
      guard let footerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultFooterView.reusableIdentifier, for: indexPath)
              as? SearchResultFooterView else {
        fatalError()
      }
      switch sectionCase {
      case .Characters:
        footerCell.seeMoreButton.targetEntity = .Characters
      case .Comics:
        footerCell.seeMoreButton.targetEntity = .Comics
      }
      footerCell.seeMoreButton.addTarget(self, action: #selector(didPressSeeMoreButton), for: .touchDown)
      return footerCell
    default:
      fatalError()
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionCase = SearchEntitiesSection(rawValue: indexPath.section) else {
      fatalError()
    }
    switch sectionCase {
    case .Comics:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultComicCell.reusableIdentifier, for: indexPath) as? SearchResultComicCell else {
        fatalError()
      }
      let comic = comics[indexPath.row]
      cell.resultTitle.text = comic.title
      if let thumbnail = comic.thumbnail {
        cell.resultTypeImage.kf.setImage(with: thumbnail.url)
      } else {
        cell.resultTypeImage.image = UIImage(systemName: "book.fill")
      }
      return cell
    case .Characters:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCharacterCell.reusableIdentifier, for: indexPath) as? SearchResultCharacterCell else {
        fatalError()
      }
      let character = characters[indexPath.row]
      cell.resultTitle.text = character.name
      if let thumbnail = character.thumbnail {
        cell.resultTypeImage.kf.setImage(with: thumbnail.url)
      } else {
        cell.resultTypeImage.image = UIImage(systemName: "person.fill")
      }
      return cell
    }
  }

  func numberOfSections(in: UICollectionView) -> Int {
    [comics, characters].filter { ($0 as! [Any]).first != nil }.count
  }
}
