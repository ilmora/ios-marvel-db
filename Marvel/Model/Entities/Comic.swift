//
//  Comic.swift
//  Marvel
//
//  Created by Tristan Djahel on 10/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct ComicDataWrapper: MarvelResultType, Decodable {
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
  var data: ComicDataContainer
}

struct ComicDataContainer: MarvelDataContainer, Decodable {
  var offset: Int
  var limit: Int
  var total: Int
  var count: Int
  var results: [Comic]
}

struct Comic: Decodable {
  var id: Int
  var title: String
  var description: String?
  var pageCount: Int?
  var images: [Image]?
  var thumbnail: Image?
  var creators: ComicCreatorList?
  var dates: [ComicDate]?
  var prices: [ComicPrice]?
}

struct ComicDate: Decodable {
  var type: String?
  var date: Date?
}

struct ComicCreatorList: Decodable {
  var available: Int?
  var returned: Int?
  var items: [ComicCreatorSummary]?
}

struct ComicCreatorSummary: Decodable {
  var name: String?
  var role: String?
}

struct ComicPrice: Decodable {
  var type: String?
  var price: Float?
}
