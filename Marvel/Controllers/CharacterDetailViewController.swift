//
// Created by Tristan Djahel on 20/08/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    private let character: Character
    private let characterDetailView: CharacterDetailView

    override func loadView() {
        view = characterDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailView.setThumbnailImage(character.thumbnail?.url)
        characterDetailView.nameLabel.text = character.name
    }

    init(character: Character) {
        self.character = character
        characterDetailView = CharacterDetailView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}