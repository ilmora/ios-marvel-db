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
  private var sections: [ComicFilterCase: UIButton]
  private var leadingHighlight: NSLayoutConstraint

  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }

  var selectedIndex: ComicFilterCase {
    didSet {
      for otherButton in sections.filter({ $0.key != selectedIndex }).map({ $0.value }) {
        otherButton.setTitleColor(.label, for: .normal)
      }
      sections[selectedIndex]?.setTitleColor(AppConstants.marvelColor, for: .normal)
      let index: Int = ComicFilterCase.allCases.distance(from: ComicFilterCase.allCases.startIndex, to: ComicFilterCase.allCases.firstIndex(of: selectedIndex)!)
      if index > 0 {
        leadingHighlight.constant = CGFloat(highlightContainer.frame.width) / CGFloat(index + 1)
      } else {
        leadingHighlight.constant = 0
      }
      UIView.animate(withDuration: 0.15) {
        self.layoutIfNeeded()
      }
    }
  }

  private func setupView() {
    mainContainer.translatesAutoresizingMaskIntoConstraints = false
    highlightView.translatesAutoresizingMaskIntoConstraints = false
    highlightContainer.translatesAutoresizingMaskIntoConstraints = false

    highlightView.backgroundColor = AppConstants.marvelColor

    mainContainer.axis = .vertical
    mainContainer.alignment = .fill
    mainContainer.distribution = .fill

    sectionsContainer.axis = .horizontal
    sectionsContainer.alignment = .fill
    sectionsContainer.distribution = .fillEqually

    addSubview(mainContainer)
    mainContainer.addArrangedSubview(sectionsContainer)
    mainContainer.addArrangedSubview(highlightContainer)

    for button in sections.sorted(by: { $0.key.rawValue < $1.key.rawValue }).map({ $0.value }) {
      button.addTarget(self, action: #selector(sectionButtonTapped(_:)), for: .touchDown)
      sectionsContainer.addArrangedSubview(button)
    }

    highlightContainer.addSubview(highlightView)

    NSLayoutConstraint.activate([
      mainContainer.topAnchor.constraint(equalTo: topAnchor),
      mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
      mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),

      highlightContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 3),
      highlightView.widthAnchor.constraint(equalTo: highlightContainer.widthAnchor, multiplier: CGFloat(1.0 / CGFloat(ComicFilterCase.allCases.count))),
      highlightView.topAnchor.constraint(equalTo: highlightContainer.topAnchor),
      highlightView.bottomAnchor.constraint(equalTo: highlightContainer.bottomAnchor),
      leadingHighlight
    ])
  }

  var sectionButtonTapped: ((ComicFilterCase) -> Void)?

  @objc
  private func sectionButtonTapped(_ sender: UIButton) {
    guard let filter = ComicFilterCase(rawValue: sender.tag), let completion = sectionButtonTapped else {
      return
    }
    completion(filter)
  }

  init() {
    highlightContainer = UIView()
    highlightView = UIView()
    sectionsContainer = UIStackView()
    mainContainer = UIStackView()
    sections = [ComicFilterCase: UIButton]()
    for filterCase in ComicFilterCase.allCases {
      let button = UIButton(type: .custom)
      button.setTitle(filterCase.localized(), for: .normal)
      button.setTitleColor(.label, for: .normal)
      button.tag = filterCase.rawValue
      sections.updateValue(button, forKey: filterCase)
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
