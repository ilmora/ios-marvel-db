//
//  Image.swift
//  Marvel
//
//  Created by Tristan Djahel on 07/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct Image: Decodable {
  var path: String?
  var `extension`: String?

  var url: URL {
    URL(string: "\(path!).\(`extension`!)")!
  }

  static var imageNotFound: Image {
    return Image(path: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extension: "jpg")
  }
}
