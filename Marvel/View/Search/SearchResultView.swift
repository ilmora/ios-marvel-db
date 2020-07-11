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

class SearchResultView: UIView {
  let tableView: UITableView

  private func setupView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reusableIdentifier)
    tableView.rowHeight = 75
    addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
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
