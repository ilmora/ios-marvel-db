//
//  ComicDetailViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ComicDetailViewController: UIViewController {
  private let comicDetailView: ComicDetailView
  private let comic: Comic
  private var translateHandle: AnyCancellable?

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
      let groupedCreators = Dictionary(grouping: creators, by: { $0.role })
      for (role, creator) in groupedCreators {
        guard let role = role else {
          continue
        }
       let creatorsName = creator.compactMap { $0.name }.joined(separator: ", ")
        let creatorText = NSMutableAttributedString(string: "\(role.localizedCapitalized) : \(creatorsName)\n")
        creatorText.setAttributes([NSAttributedString.Key.font: keyInfoFont], range: NSRange(location: 0, length: role.count))
        text.append(creatorText)
      }
      comicDetailView.creatorsLabel.attributedText = text
    }

    if let summary = comic.description {
      translateHandle = GoogleTranslateAPI().translate(text: summary).sink(
        receiveCompletion: { _ in},
        receiveValue: { translatedText in
          let summaryText = NSMutableAttributedString()
          let summaryTextTitle = NSMutableAttributedString(string: "\("summary".localized.capitalized)\n", attributes: [NSAttributedString.Key.font: self.keyInfoFont])
          let summaryTextContent = NSMutableAttributedString(string: translatedText)
          summaryText.append(summaryTextTitle)
          summaryText.append(summaryTextContent)
          DispatchQueue.main.async {
            self.comicDetailView.summaryLabel.attributedText = summaryText
          }
        })
    } else {
      comicDetailView.container.removeArrangedSubview(comicDetailView.summaryLabel)
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
