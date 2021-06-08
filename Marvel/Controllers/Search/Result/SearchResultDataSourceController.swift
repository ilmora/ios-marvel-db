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
  // MARK: Fetch from api
  private let api = MarvelAPI()

  private let collectionView: UICollectionView

  private var inputSearchText: String

  @Published private(set) var comics = [Comic]()
  private var offsetComics = 0
  private var comicsHandle: AnyCancellable?

  @Published private(set) var characters = [Character]()
  private var offsetCharacters = 0
  private var charactersHandle: AnyCancellable?

  func fetchResultFromApi(_ newSearchValue: String?) {
    offsetCharacters = 0
    offsetComics = 0
    comics = [Comic]()
    characters = [Character]()
    guard let newSearchValue = newSearchValue, newSearchValue != "" else {
      return
    }

    inputSearchText = newSearchValue
    comicsHandle = api.fetchComics(containing: newSearchValue, offset: offsetComics)
      .sink(receiveCompletion: { _ in

      }, receiveValue: { comicDataContainer in
        self.comics = comicDataContainer.results
        self.offsetComics += comicDataContainer.count + 1
      })
    charactersHandle = api.fetchCharacters(containing: newSearchValue, offset: offsetCharacters)
      .sink(receiveCompletion: { _ in

      }, receiveValue: { characterDataContainer in
        self.characters = characterDataContainer.results
        self.offsetCharacters += characterDataContainer.count + 1
      })
  }

  @objc private func didPressSeeMoreButton(_ sender: UIButton) {
    guard let sender = sender as? SeeMoreButton, let targetEntity = sender.targetEntity else {
      return
    }
    switch targetEntity {
    case .Characters:
      charactersHandle = api.fetchCharacters(containing: inputSearchText, offset: offsetCharacters)
        .sink(receiveCompletion: { _ in

        }, receiveValue: { characterDataContainer in
          self.characters.append(contentsOf: characterDataContainer.results)
          self.offsetCharacters += characterDataContainer.count + 1
        })
    case .Comics:
      comicsHandle = api.fetchComics(containing: inputSearchText, offset: offsetComics)
        .sink(receiveCompletion: { _ in

        }, receiveValue: { comicDataContainer in
          self.comics.append(contentsOf: comicDataContainer.results)
          self.offsetComics += comicDataContainer.count + 1
        })
    }
  }

  // MARK: Diffable data source
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
        footerCell.seeMoreButton.addTarget(self, action: #selector(self.didPressSeeMoreButton), for: .touchDown)
        return footerCell
      default:
        fatalError()
      }
    }
    return dataSource
  }

  // MARK: Init
  init(_ collectionView: UICollectionView) {
    inputSearchText = ""
    self.collectionView = collectionView
  }
}
