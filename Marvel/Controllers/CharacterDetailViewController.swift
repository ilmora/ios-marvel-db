//
// Created by Tristan Djahel on 20/08/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    private let character: Character
    private let characterDetailView: CharacterDetailView
    private let characterDetailDataSource: CharacterDetailDataSourceController

    override func loadView() {
        view = characterDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailView.setThumbnailImage(character.thumbnail?.url)
        characterDetailView.nameLabel.text = character.name
        characterDetailView.collectionView.dataSource = characterDetailDataSource
        characterDetailView.collectionView.register(SeriesCollectionCell.self, forCellWithReuseIdentifier: SeriesCollectionCell.reusableIdentifier)
        DispatchQueue.main.async {
            self.characterDetailView.collectionView.reloadData()
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