//
//  CharacterViewCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 02/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class CharacterViewCell: UITableViewCell {
  private let characterNameLabel: UILabel

  var characterName: String {
    didSet {
      DispatchQueue.main.async {
        self.characterNameLabel.text = self.characterName
      }
    }
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    characterNameLabel = UILabel()
    characterName = ""
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(characterNameLabel)
    NSLayoutConstraint.activate([
      characterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      characterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      characterNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
