//
// Created by Tristan Djahel on 20/08/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class CharacterDetailViewController: UIViewController, UICollectionViewDelegate {
  private let character: Character
  private let characterDetailView: CharacterDetailView
  private let characterDetailDataSource: CharacterDetailDataSourceController
  private var seriesHandle: AnyCancellable?
  private var translateHandle: AnyCancellable?
  private var translatedDescription: String?

  override func loadView() {
    view = characterDetailView
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let series = characterDetailDataSource.series[indexPath.row]
    self.navigationController?.pushViewController(SeriesDetailViewController(series: series), animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    characterDetailView.collectionView.delegate = self
    let translateClient = GoogleTranslateAPI()
    if let description = character.description {
      characterDetailView.switchTextLang.setTitle("DisplayTranslatedText".localized, for: .normal)
      translateHandle = translateClient.translate(characterDetailDescription: description)
      .sink(receiveCompletion: { completion in
      }, receiveValue: { translatedText in
        DispatchQueue.main.async {
          self.translatedDescription = translatedText
          self.characterDetailView.descriptionLabel.text = translatedText
          self.characterDetailView.switchTextLang.setTitle("DisplayOriginalText".localized, for: .normal)
        }
      })
      characterDetailView.switchTextLang.addTarget(self, action: #selector(switchDescriptionCulture), for: .touchDown)
    }
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

  @objc private func switchDescriptionCulture() {
    if characterDetailView.switchTextLang.title(for: .normal) == "DisplayOriginalText".localized {
      DispatchQueue.main.async {
        self.characterDetailView.switchTextLang.setTitle("DisplayTranslatedText".localized, for: .normal)
        self.characterDetailView.descriptionLabel.text = self.character.description
      }
    } else if characterDetailView.switchTextLang.title(for: .normal) == "DisplayTranslatedText".localized {
      self.characterDetailView.switchTextLang.setTitle("DisplayOriginalText".localized, for: .normal)
      self.characterDetailView.descriptionLabel.text = self.translatedDescription
    }
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
