//
//  Cache.swift
//  Marvel
//
//  Created by Tristan Djahel on 06/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct Cache {
  private enum Keys: String {
    case UserSearchHistory = "userSearchHistory"
  }
  static var userSearchHistory: [String] {
    get {
      UserDefaults.standard.object(forKey: Keys.UserSearchHistory.rawValue) as? [String] ?? [String]()
    }
    set {
      UserDefaults.standard.set(newValue, forKey: Keys.UserSearchHistory.rawValue)
    }
  }
}
