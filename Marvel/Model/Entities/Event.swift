//
//  Event.swift
//  Marvel
//
//  Created by Tristan Djahel on 04/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct EventDataWrapper: MarvelResultType, Decodable {
  var data: EventDataContainer
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
}

struct EventDataContainer: MarvelDataContainer, Decodable {
  var offset: Int
  var limit: Int
  var total: Int
  var count: Int
  var results: [Event]
}

struct Event: Identifiable, Decodable {
  var id: Int
  var title: String
  var description: String
}
