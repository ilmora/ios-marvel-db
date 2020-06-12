//
//  CharacterViewCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 02/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CharacterViewCell: UITableViewCell {
  private let container: UIStackView
  private let characterNameLabel: UILabel
  private let characterThumbmail: UIImageView

  func configureCell(with character: Character) {
    characterNameLabel.text = character.name

    if let path = character.thumbnail?.path,
      let `extension` = character.thumbnail?.extension,
      let thumbmailURL = URL(string: "\(path).\(`extension`)") {
      characterThumbmail.kf.setImage(with: thumbmailURL)
    }
  }

  private func layoutComponents() {
    container.translatesAutoresizingMaskIntoConstraints = false
    characterThumbmail.translatesAutoresizingMaskIntoConstraints = false

    container.addArrangedSubview(characterThumbmail)
    container.addArrangedSubview(characterNameLabel)
    container.spacing = 10
    
    contentView.addSubview(container)
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: contentView.topAnchor),
      container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      characterThumbmail.widthAnchor.constraint(equalTo: contentView.heightAnchor)
    ])
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    characterNameLabel = UILabel()
    characterThumbmail = UIImageView()
    container = UIStackView()
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layoutComponents()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
