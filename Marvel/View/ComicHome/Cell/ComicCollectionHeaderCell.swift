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
  private let comicFilterView: UISegmentedControl
  private var comicsFilterHandle: AnyCancellable?
  var viewModel: ComicHomeViewModel? {
    didSet {
      comicsFilterHandle = viewModel?.$comicsFilter.sink(receiveCompletion: {_ in
        self.comicsFilterHandle = nil
      }, receiveValue: { newComicsFilter in
        DispatchQueue.main.async {
          for index in 0..<newComicsFilter.count {
            self.comicFilterView.insertSegment(withTitle: newComicsFilter[index], at: index, animated: true)
          }
          if self.comicFilterView.numberOfSegments > 0 {
            self.comicFilterView.selectedSegmentIndex = 0
            if let selectedComicFilter = self.viewModel?.comicsFilter[self.comicFilterView.selectedSegmentIndex] {
              self.viewModel?.selectedComicFilter = selectedComicFilter
            }
          }
        }
      })
    }
  }

  @objc private func comicFilterChanged(_ sender: UISegmentedControl) {
    guard let viewModel = self.viewModel else {
      return
    }
    viewModel.selectedComicFilter = viewModel.comicsFilter[sender.selectedSegmentIndex]
  }

  private func layoutComponents() {
    comicFilterView.addTarget(self, action: #selector(self.comicFilterChanged), for: .valueChanged)
    comicFilterView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(comicFilterView)
    NSLayoutConstraint.activate([
      comicFilterView.topAnchor.constraint(equalTo: topAnchor),
      comicFilterView.leadingAnchor.constraint(equalTo: leadingAnchor),
      comicFilterView.trailingAnchor.constraint(equalTo: trailingAnchor),
      comicFilterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    ])
  }

  override init(frame: CGRect) {
    comicFilterView = UISegmentedControl()
    super.init(frame: frame)
    layoutComponents()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
