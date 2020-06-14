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
  private var charactersHandle: AnyCancellable?
  private let dataSource = CharacterListDataSourceController()
  private var charactersListHandle: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()
    charactersView.tableView.dataSource = self.dataSource
    charactersListHandle = dataSource.$characters.sink(receiveValue: { _ in
      DispatchQueue.main.async {
        self.charactersView.tableView.reloadData()
      }
    })
    dataSource.fetchData()
  }

  override func loadView() {
    view = charactersView
  }

  init() {
    charactersView = CharactersListView()
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
