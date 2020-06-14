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
  private static func getFontSizeForScreen(baseFontSize: CGFloat) -> CGFloat {
    let width = UIScreen.main.bounds.width
    return baseFontSize + width * 0.012
  }

  static let marvelColor = UIColor(named: "Marvel")!
  static let comicBackgroundColor = UIColor.systemGray6
  static let comicTitle = UIFont(name: "Roboto-Bold", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!
  static let comicLargeTitle = UIFont(name: "Roboto-black", size: AppConstants.getFontSizeForScreen(baseFontSize: 30))!
  static let comicBody = UIFont(name: "Roboto-Light", size: AppConstants.getFontSizeForScreen(baseFontSize: 14))!

  struct Comic {
    static let newComicsSection = 0
    static let futureComicsSection = 1
  }
}
