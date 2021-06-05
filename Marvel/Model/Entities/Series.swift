//
//  Series.swift
//  Marvel
//
//  Created by Tristan Djahel on 04/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct SeriesDataWrapper: MarvelResultType, Decodable {
  var data: SeriesDataContainer
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
}

struct SeriesDataContainer: MarvelDataContainer, Decodable {
  var offset: Int
  var limit: Int
  var total: Int
  var count: Int
  var results: [Series]
}

struct Series: Decodable, Identifiable {
  var id: Int
  var title: String?
  var description: String?
  var resourceURI: String?
  var startYear: Int
  var endYear: Int
  var rating: String?
  var thumbnail: Image
  var characters: CharacterList?
  var next: SeriesSummary?
  var previous: SeriesSummary?
}

struct SeriesList: Decodable, EntityList, Hashable {
  static func == (lhs: SeriesList, rhs: SeriesList) -> Bool {
    lhs.collectionURI == rhs.collectionURI
  }

  var available: Int?
  var returned: Int?
  var collectionURI: String?
  var items: [SeriesSummary]?
}

struct SeriesSummary: Decodable, EntitySummary, Hashable {
  var resourceURI: String?
  var name: String?
}
