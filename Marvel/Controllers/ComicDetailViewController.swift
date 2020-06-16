//
//  ComicDetailViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class ComicDetailViewController: UIViewController {
  private let comicDetailView: ComicDetailView
  private let comic: Comic

  private let keyInfoFont = UIFont(name: "Roboto-Bold", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!

  override func loadView() {
    view = comicDetailView
  }

  private func reloadData() {
    if let imageComponent = comic.images?.first, let imagePath = imageComponent.path, let imageExtension = imageComponent.extension {
      var imageURL = URL(string: imagePath)!
      imageURL.appendPathExtension(imageExtension)
      comicDetailView.coverImage.kf.setImage(with: imageURL)
    }
    comicDetailView.titleLabel.text = comic.title

    if let publicationDate = comic.dates?.first(where: { $0.type == "onsaleDate" }) {
      let formatter = DateFormatter()
      formatter.dateStyle = .full
      let dateLabel = "OnSaleDate".localized
      let text = NSMutableAttributedString(string: "\(dateLabel) : \(formatter.string(from: publicationDate.date!).localizedCapitalized)")
      text.setAttributes([NSAttributedString.Key.font: keyInfoFont], range: NSRange(location: 0, length: dateLabel.count))
      comicDetailView.publishedDateLabel.attributedText = text
    }

    if let creators = comic.creators?.items {
      let text = NSMutableAttributedString()
      for creator in creators.sorted(by: { $0.role ?? "" < $1.role ?? "" }) {
        guard let name = creator.name, let role = creator.role?.localized else {
          continue
        }
        let creatorText = NSMutableAttributedString(string: "\(role.localizedCapitalized) : \(name)\n")
        creatorText.setAttributes([NSAttributedString.Key.font: keyInfoFont], range: NSRange(location: 0, length: role.count))
        text.append(creatorText)
      }
      comicDetailView.creatorsLabel.attributedText = text
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    reloadData()
  }

  init(_ comic: Comic) {
    comicDetailView = ComicDetailView()
    self.comic = comic
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
