//
//  AppConstants.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
  static func getFontSizeForScreen(baseFontSize: CGFloat) -> CGFloat {
    let width = UIScreen.main.bounds.width
    return baseFontSize + width * 0.012
  }

  static let marvelColor = UIColor(named: "Marvel")!
  static let backgroundColor = UIColor.secondarySystemBackground
  static let title = UIFont(name: "Roboto-Regular", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!
  static let largeTitle = UIFont(name: "Roboto-Bold", size: AppConstants.getFontSizeForScreen(baseFontSize: 30))!
  static let body = UIFont(name: "Roboto-Light", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!
  static let headerSearchResultFont = UIFont(name: "Raleway-Bold", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!
}

enum ComicFilterCase: String, CaseIterable {
  case New = "comics_new"
  case Future = "comics_to_come"
}

enum SearchEntitiesSectionWrapper: Hashable {
  static func == (lhs: SearchEntitiesSectionWrapper, rhs: SearchEntitiesSectionWrapper) -> Bool {
    lhs.hashValue == rhs.hashValue
  }

  case Characters(Character)
  case Comics(Comic)
}

enum SearchEntitiesSection: Int, CaseIterable {

  case Characters = 0
  case Comics = 1

  var title: String {
    switch self {
    case .Comics:
      return "Comic".localized
    case .Characters:
      return "Characters".localized
    }
  }
}
