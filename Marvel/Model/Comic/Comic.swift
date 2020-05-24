//
//  Comic.swift
//  Marvel
//
//  Created by Tristan Djahel on 10/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct ComicDataWrapper: MarvelResultType, Decodable {
  var code: Int?
  var status: String?
  var copyright: String?
  var attributionText: String?
  var attributionHtml: String?
  var etag: String?
  var data: ComicDataContainer
}

struct ComicDataContainer: Decodable {
  var offset: Int?
  var limit: Int?
  var total: Int?
  var count: Int?
  var results: [Comic]?
}

struct Comic: Decodable {
  var id: Int?
  var title: String?
  var description: String?
  var pageCount: Int?
  var images: [ComicImage]?
  var thumbnail: ComicImage?
  var creators: ComicCreatorList?
}

struct ComicImage: Decodable {
  var path: String?
  var `extension`: String?
}
