//
//  CharactersListViewMode;.swift
//  Marvel
//
//  Created by Tristan Djahel on 07/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import Combine

class CharactersViewModel {
  @Published var characters: [Character]

  init() {
    characters = [Character]()
  }
}
