//
//  ComicDetailViewModel.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import Combine

class ComicDetailViewModel {
  @Published var comic: Comic

  init() {
    comic = Comic()
  }
}
