//
//  ComicHomeViewModel.swift
//  Marvel
//
//  Created by Tristan Djahel on 21/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import Combine

final class ComicHomeViewModel {
  // C -> V
  @Published var newComics: [Comic]
  @Published var nextComics: [Comic]

  // V -> C
  @Published var selectedComic: Comic?

  init() {
    newComics = [Comic]()
    nextComics = [Comic]()
  }
}
