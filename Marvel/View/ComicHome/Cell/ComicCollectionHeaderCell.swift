//
//  ComicCollectionHeaderCell.swift
//  Marvel
//
//  Created by Tristan Djahel on 22/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import MagazineLayout
import Combine

class ComicCollectionHeaderCell: MagazineLayoutCollectionReusableView {
  private let title: UILabel

  func setSectionTitle(_ title: String) {
    DispatchQueue.main.async {
      self.title.text = title
    }
  }

  private func layoutComponents() {
    title.translatesAutoresizingMaskIntoConstraints = false
    title.backgroundColor = AppConstants.comicBackgroundColor
    title.font = AppConstants.comicLargeTitle

    addSubview(title)
    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: leadingAnchor),
      title.topAnchor.constraint(equalTo: topAnchor),
      title.bottomAnchor.constraint(equalTo: bottomAnchor),
      title.widthAnchor.constraint(equalTo: widthAnchor)
    ])
  }

  override init(frame: CGRect) {
    title = UILabel()
    super.init(frame: frame)
    layoutComponents()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
