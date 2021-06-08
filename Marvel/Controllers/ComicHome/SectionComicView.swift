//
//  SectionComicView.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/06/2021.
//  Copyright © 2021 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SectionComicView: UIView {

  private let highlightContainer: UIView
  private let highlightView: UIView
  private let sectionsContainer: UIStackView
  private let mainContainer: UIStackView
  private var sections: [ComicFilterCase: UILabel]
  private var leadingHighlight: NSLayoutConstraint

  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }

  var selectedIndex: ComicFilterCase {
    didSet {
      for label in sections.filter({ $0.key != selectedIndex }).values {
        label.textColor = .label
      }
      sections[selectedIndex]?.textColor = AppConstants.marvelColor

      let index: Int = ComicFilterCase.allCases.distance(from: ComicFilterCase.allCases.startIndex, to: ComicFilterCase.allCases.firstIndex(of: selectedIndex)!)
      if index > 0 {
        leadingHighlight.constant = CGFloat(highlightContainer.frame.width) / CGFloat(index + 1)
      } else {
        leadingHighlight.constant = 0
      }
      layoutIfNeeded()
    }
  }

  private func setupView() {
    mainContainer.translatesAutoresizingMaskIntoConstraints = false
    highlightView.translatesAutoresizingMaskIntoConstraints = false
    highlightContainer.translatesAutoresizingMaskIntoConstraints = false

    highlightView.backgroundColor = AppConstants.marvelColor

    mainContainer.axis = .vertical
    mainContainer.alignment = .fill
    mainContainer.distribution = .fillProportionally

    sectionsContainer.axis = .horizontal
    sectionsContainer.alignment = .fill
    sectionsContainer.distribution = .fillEqually

    addSubview(mainContainer)
    mainContainer.addArrangedSubview(sectionsContainer)
    mainContainer.addArrangedSubview(highlightContainer)

    for label in sections.sorted(by: { $0.key.rawValue < $1.key.rawValue }).map({ $0.value }) {
      sectionsContainer.addArrangedSubview(label)
    }

    highlightContainer.addSubview(highlightView)

    NSLayoutConstraint.activate([
      mainContainer.topAnchor.constraint(equalTo: topAnchor),
      mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
      mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),

      highlightContainer.heightAnchor.constraint(equalToConstant: 3),
      highlightView.widthAnchor.constraint(equalTo: highlightContainer.widthAnchor, multiplier: CGFloat(1.0 / CGFloat(ComicFilterCase.allCases.count))),
      highlightView.topAnchor.constraint(equalTo: highlightContainer.topAnchor),
      highlightView.bottomAnchor.constraint(equalTo: highlightContainer.bottomAnchor),
      leadingHighlight
    ])
  }

  init() {
    highlightContainer = UIView()
    highlightView = UIView()
    sectionsContainer = UIStackView()
    mainContainer = UIStackView()
    sections = [ComicFilterCase: UILabel]()
    for filterCase in ComicFilterCase.allCases {
      let label = UILabel()
      label.text = filterCase.localized()
      label.textAlignment = .center
      sections.updateValue(label, forKey: filterCase)
    }
    leadingHighlight = highlightView.leadingAnchor.constraint(equalTo: highlightContainer.leadingAnchor, constant: 0)
    selectedIndex = .New
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
