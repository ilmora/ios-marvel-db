//
//  ComicCharacter.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct ComicCreatorList: Decodable {
  var available: Int?
  var returned: Int?
  var items: [ComicCreatorSummary]
}

struct ComicCreatorSummary: Decodable {
  var name: String?
  var role: String?
}
