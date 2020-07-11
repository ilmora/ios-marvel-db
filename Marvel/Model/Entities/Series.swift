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
  var title: String
  var description: String
}
