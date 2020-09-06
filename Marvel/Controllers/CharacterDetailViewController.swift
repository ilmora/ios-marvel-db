//
// Created by Tristan Djahel on 20/08/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class CharacterDetailViewController: UIViewController {
  private let character: Character
  private let characterDetailView: CharacterDetailView
  private let characterDetailDataSource: CharacterDetailDataSourceController
  private var seriesHandle: AnyCancellable?

  override func loadView() {
    view = characterDetailView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    characterDetailView.setThumbnailImage(character.thumbnail?.url)
    characterDetailView.descriptionLabel.text = character.description
    characterDetailView.nameLabel.text = character.name
    characterDetailView.collectionView.dataSource = characterDetailDataSource
    characterDetailView.collectionView.register(SeriesCollectionCell.self, forCellWithReuseIdentifier: SeriesCollectionCell.reusableIdentifier)
    characterDetailView.collectionView.register(SeriesHeaderCollectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SeriesHeaderCollectionCell.reusableIdentifier)
    characterDetailDataSource.fetchSeries()
    seriesHandle = characterDetailDataSource.$series.sink(receiveValue: { _ in
      DispatchQueue.main.async {
        self.characterDetailView.collectionView.reloadData()
      }
    })
  }

  init(character: Character) {
    self.character = character
    characterDetailView = CharacterDetailView()
    characterDetailDataSource = CharacterDetailDataSourceController(character: character)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
