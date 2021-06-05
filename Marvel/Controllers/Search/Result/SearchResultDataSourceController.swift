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

  private let collectionView: UICollectionView

  @Published private var inputSearchText: String?
  private var textInputHandle: AnyCancellable?

  @Published private(set) var comics = [Comic]()
  private var comicsHandle: AnyCancellable?

  @Published private(set) var characters = [Character]()
  private var charactersHandle: AnyCancellable?

  var didPressSeeMoreButtonHandler: (() -> Void)?

  func fetchResultFromApi(_ newSearchValue: String?) {
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

  @objc private func didPressSeeMoreButton(_ sender: UIButton) {
    if let handler = didPressSeeMoreButtonHandler {
      handler()
    }
  }

  func makeSnapshot() -> NSDiffableDataSourceSnapshot<SearchEntitiesSection, SearchEntitiesSectionWrapper> {
    var snapshot = NSDiffableDataSourceSnapshot<SearchEntitiesSection, SearchEntitiesSectionWrapper>()
    snapshot.appendSections(SearchEntitiesSection.allCases)
    snapshot.appendItems(characters.map { SearchEntitiesSectionWrapper.Characters($0) }, toSection: .Characters)
    snapshot.appendItems(comics.map { SearchEntitiesSectionWrapper.Comics($0) }, toSection: .Comics)
    return snapshot
  }

  func makeDataSource() -> UICollectionViewDiffableDataSource<SearchEntitiesSection, SearchEntitiesSectionWrapper> {
    let dataSource =
    UICollectionViewDiffableDataSource<SearchEntitiesSection, SearchEntitiesSectionWrapper>(collectionView: collectionView, cellProvider: { collectionView, indexPath, wrapper in
      switch wrapper {
      case .Characters(let character):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCharacterCell.reusableIdentifier, for: indexPath) as? SearchResultCharacterCell else {
          fatalError()
        }
        cell.resultTitle.text = character.name
        if let thumbnail = character.thumbnail {
          cell.resultTypeImage.kf.setImage(with: thumbnail.url)
        } else {
          cell.resultTypeImage.image = UIImage(systemName: "person.fill")
        }
        return cell
      case .Comics(let comic):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultComicCell.reusableIdentifier, for: indexPath) as? SearchResultComicCell else {
          fatalError()
        }
        cell.resultTitle.text = comic.title
        if let thumbnail = comic.thumbnail {
          cell.resultTypeImage.kf.setImage(with: thumbnail.url)
        } else {
          cell.resultTypeImage.image = UIImage(systemName: "book.fill")
        }
        return cell
      }
    })

    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
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
        //footerCell.seeMoreButton.addTarget(self, action: #selector(didPressSeeMoreButton), for: .touchDown)
        return footerCell
      default:
        fatalError()
      }
    }
    return dataSource
  }

  init(_ collectionView: UICollectionView) {
    self.collectionView = collectionView
  }
}
