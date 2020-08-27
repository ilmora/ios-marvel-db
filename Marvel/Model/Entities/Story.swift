//
//  Stories.swift
//  Marvel
//
//  Created by Tristan Djahel on 04/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct StoryDataWrapper: MarvelResultType, Decodable {
  var data: StoryDataContainer
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
}

struct StoryDataContainer: MarvelResultType, Decodable {
  var data: Story
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
}

struct Story: Decodable, Identifiable {
  var id: Int
  var title: String
  var description: String
}

struct StoryList: Decodable, EntityList {
  var available: Int?
  var returned: Int?
  var collectionURI: String?
  var items: [StorySummary]?
}

struct StorySummary: Decodable, EntitySummary {
  var resourceURI: String?
  var name: String?
  var type: String?
}