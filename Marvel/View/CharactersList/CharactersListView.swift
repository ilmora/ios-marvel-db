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

class CharactersListView: UIView {
  let tableView: UITableView

  private func setupView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.reusableIdentifier)
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

  init() {
    tableView = UITableView(frame: .zero, style: .plain)
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
