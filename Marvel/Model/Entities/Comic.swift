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

struct Comic: Decodable, Hashable {
  static func == (lhs: Comic, rhs: Comic) -> Bool {
    lhs.id == rhs.id
  }

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

struct ComicDate: Decodable, Hashable {
  var type: String?
  var date: Date?
}

struct ComicCreatorList: Decodable, Hashable {
  static func == (lhs: ComicCreatorList, rhs: ComicCreatorList) -> Bool {
    guard let items1 = lhs.items, let items2 = rhs.items else {
      return false
    }
    return items1.elementsEqual(items2) { $0.name == $1.name }
  }

  var available: Int?
  var returned: Int?
  var items: [ComicCreatorSummary]?
}

struct ComicCreatorSummary: Decodable, Hashable {
  var name: String?
  var role: String?
}

struct ComicPrice: Decodable, Hashable {
  var type: String?
  var price: Float?
}

struct ComicList: Decodable, EntityList, Hashable {
  static func == (lhs: ComicList, rhs: ComicList) -> Bool {
    lhs.collectionURI == rhs.collectionURI
  }

  var available: Int?
  var returned: Int?
  var collectionURI: String?
  var items: [ComicSummary]?
}

struct ComicSummary: Decodable, EntitySummary, Hashable {
  var resourceURI: String?
  var name: String?
}
