//
//  CharacterListDataSourceController.swift
//  Marvel
//
//  Created by Tristan Djahel on 14/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class CharacterListDataSourceController: NSObject, UITableViewDataSource {
  private let marvelAPI = MarvelAPI()
  @Published private(set) var characters: [Character]
  private var fetchCharactersHandle: AnyCancellable?

  private var charactersPrefix: [String] {
    characters
      .compactMap { $0.name }
      .compactMap { String($0.first!) }
      .removeDuplicates()
  }

  func fetchData() {
    fetchCharactersHandle = marvelAPI.fetchAllCharacters()
      .sink(receiveCompletion: { error in
      }, receiveValue: { characters in
        self.characters.append(contentsOf: characters)
      })
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    charactersPrefix[section]
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let startsWithCharacter = charactersPrefix[section]

    return characters
      .compactMap { $0.name }
      .filter { $0.hasPrefix(startsWithCharacter) }
      .count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    charactersPrefix.count
  }

  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    charactersPrefix
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.reusableIdentifier, for: indexPath)
      as? CharacterViewCell else {
      fatalError()
    }
    let firstCharOfCharacter = charactersPrefix[indexPath.section]

    let character = characters.filter { $0.name.hasPrefix(firstCharOfCharacter) }[indexPath.row]

    cell.characterNameLabel.text = character.name
    if let path = character.thumbnail?.path,
      let `extension` = character.thumbnail?.extension,
      let thumbmailURL = URL(string: "\(path).\(`extension`)") {
      cell.characterThumbmail.kf.setImage(with: thumbmailURL)
    }
    return cell
  }

  override init() {
    characters = [Character]()
    super.init()
  }
}
