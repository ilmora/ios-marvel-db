//
//  CharactersListView.swift
//  Marvel
//
//  Created by Tristan Djahel on 02/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class CharactersListView: UIView, UITableViewDataSource, UITableViewDelegate {
  private let tableView: UITableView
  private let searchBar: UISearchBar

  private let viewModel: CharactersViewModel
  private var charactersHandle: AnyCancellable?

  private var charactersPrefix: [String] {
    viewModel.characters
      .compactMap { $0.name }
      .compactMap { String($0.first!) }
      .removeDuplicates()
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    charactersPrefix[section]
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let startsWithCharacter = charactersPrefix[section]

    return viewModel.characters
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
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.reusableIdentifier, for: indexPath) as? CharacterViewCell else {
      fatalError()
    }
    let firstCharOfCharacter = charactersPrefix[indexPath.section]

    let character = viewModel.characters.filter { $0.name?.hasPrefix(firstCharOfCharacter) ?? false }[indexPath.row]
    cell.configureCell(with: character)
    return cell
  }

  private func setupView() {
    charactersHandle = viewModel.$characters.sink(receiveCompletion: { _ in
      self.charactersHandle = nil
    }, receiveValue: { characters in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    })
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.reusableIdentifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 75
    addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  init(_ viewModel: CharactersViewModel) {
    tableView = UITableView(frame: .zero, style: .plain)
    searchBar = UISearchBar()
    self.viewModel = viewModel
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
