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
  static let backgroundColor = UIColor.systemGray6
  static let title = UIFont(name: "Roboto-Regular", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!
  static let largeTitle = UIFont(name: "Roboto-Bold", size: AppConstants.getFontSizeForScreen(baseFontSize: 30))!
  static let body = UIFont(name: "Roboto-Light", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!
  static let headerSerachResultFont = UIFont(name: "Raleway-Bold", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!
}

enum ComicFilterCase: String, CaseIterable {
  case New = "comics_new"
  case Future = "comics_to_come"
}

enum SearchEntitiesSectionTitles: Int {
  case Comics = 0
  case Characters
}