//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 26/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class CharactersListViewController: UIViewController {
  private let charactersView: CharactersListView
  private let marvelAPI = MarvelAPI()
  private var charactersHandle: AnyCancellable?
  private let viewModel: CharactersViewModel

  override func viewDidLoad() {
    super.viewDidLoad()
    charactersHandle = marvelAPI.fetchAllCharacters()
    .sink(receiveCompletion: { error in
    }, receiveValue: { characters in
      self.viewModel.characters.append(contentsOf: characters)
    })
  }

  override func loadView() {
    view = charactersView
  }

  init() {
    viewModel = CharactersViewModel()
    charactersView = CharactersListView(viewModel)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
