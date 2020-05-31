//
//  ComicDetailView.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Combine

class ComicDetailView: UIView {
  private let scrollView: UIScrollView

  private let container: UIStackView

  private let titleLabel: UILabel

  private let publishedDateLabel: UILabel
  private var creatorsLabel: UILabel

  private let coverImage: UIImageView
  private let viewModel: ComicDetailViewModel
  private var viewModelHandle: AnyCancellable?

  private func reloadData() {
    if let imageComponent = viewModel.comic.images?.first, let imagePath = imageComponent.path, let imageExtension = imageComponent.extension {
      var imageURL = URL(string: imagePath)!
      imageURL.appendPathExtension(imageExtension)
      coverImage.kf.setImage(with: imageURL)
    }
    if let comicTitle = viewModel.comic.title {
      titleLabel.text = comicTitle
    }

    if let publicationDate = viewModel.comic.dates?.first(where: { $0.type == "onsaleDate" }) {
      let formatter = DateFormatter()
      formatter.dateStyle = .full
      let dateLabel = "DATE DE SORTIE"
      let text = NSMutableAttributedString(string: "\(dateLabel) : \(formatter.string(from: publicationDate.date!))")
      text.setAttributes([NSAttributedString.Key.font: AppConstants.comicBody], range: NSRange(location: 0, length: text.string.count))
      text.setAttributes([NSAttributedString.Key.font: AppConstants.comicTitle], range: NSRange(location: 0, length: dateLabel.count))
      publishedDateLabel.attributedText = text
    }

    if let creators = viewModel.comic.creators?.items {
      let text = NSMutableAttributedString()
      for creator in creators.sorted(by: { $0.role ?? "" < $1.role ?? "" }) {
        guard let name = creator.name, let role = creator.role else {
          continue
        }
        let creatorText = NSMutableAttributedString(string: "\(role.uppercased()) : \(name)\n")
        creatorText.setAttributes([NSAttributedString.Key.font: AppConstants.comicTitle], range: NSRange(location: 0, length: role.count))
        text.append(creatorText)
      }
      creatorsLabel.attributedText = text
    }
  }

  private func setupView() {
    viewModelHandle = self.viewModel.$comic.sink(receiveCompletion: { _ in
      self.viewModelHandle = nil
    }, receiveValue: { _ in
      self.reloadData()
    })

    backgroundColor = AppConstants.comicBackgroundColor

    scrollView.translatesAutoresizingMaskIntoConstraints = false
    coverImage.translatesAutoresizingMaskIntoConstraints = false
    container.translatesAutoresizingMaskIntoConstraints = false

    container.axis = .vertical
    container.alignment = .fill
    container.spacing = 40

    coverImage.layer.shadowColor = UIColor.black.cgColor
    coverImage.layer.shadowOffset = CGSize(width: 0, height: 0)
    coverImage.layer.shadowRadius = 3
    coverImage.layer.shadowOpacity = 1

    scrollView.showsVerticalScrollIndicator = false

    titleLabel.numberOfLines = 0
    titleLabel.font = AppConstants.comicLargeTitle

    creatorsLabel.numberOfLines = 0

    publishedDateLabel.font = AppConstants.comicBody

    container.addArrangedSubview(titleLabel)
    container.addArrangedSubview(coverImage)
    container.addArrangedSubview(publishedDateLabel)
    container.addArrangedSubview(creatorsLabel)
    scrollView.addSubview(container)
    addSubview(scrollView)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      container.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
      container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
      container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 10),
      container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      container.centerXAnchor.constraint(equalTo: centerXAnchor),

      coverImage.widthAnchor.constraint(equalTo: container.widthAnchor),
      coverImage.heightAnchor.constraint(equalTo: coverImage.widthAnchor, multiplier: 1.5),
    ])
  }

  init(_ viewModel: ComicDetailViewModel) {
    self.viewModel = viewModel
    coverImage = UIImageView()
    container = UIStackView()
    titleLabel = UILabel()
    scrollView = UIScrollView()
    publishedDateLabel = UILabel()
    creatorsLabel = UILabel()
    super.init(frame: .zero)
    setupView()
    reloadData()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
