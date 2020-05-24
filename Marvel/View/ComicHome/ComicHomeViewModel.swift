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
  @Published var comics: [Comic]
  @Published var comicsFilter: [String]

  // V -> C
  @Published var selectedComic: Comic?
  @Published var selectedComicFilter: String

  init() {
    comics = [Comic]()
    comicsFilter = [String]()
    selectedComicFilter = ""
  }
}
