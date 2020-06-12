//
//  ArrayExtensions.swift
//  Marvel
//
//  Created by Tristan Djahel on 10/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
  func removeDuplicates() -> [Element] {
    var uniques = [Element]()

    for element in self {
      if !uniques.contains(element) {
        uniques.append(element)
      }
    }
    return uniques
  }
}
