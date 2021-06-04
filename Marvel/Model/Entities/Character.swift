//
//  Character.swift
//  Marvel
//
//  Created by Tristan Djahel on 07/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct CharacterDataWrapper: MarvelResultType, Decodable {
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
  var data: CharacterDataContainer
}

struct CharacterDataContainer: MarvelDataContainer, Decodable {
  var offset: Int
  var limit: Int
  var total: Int
  var count: Int
  var results: [Character]
}

struct Character: Decodable {
  var id: Int
  var name: String
  var description: String?
  var modified: Date?
  var resourceURI: String?
  var thumbnail: Image?
  var comics: ComicList?
  var stories: StoryList?
  var series: SeriesList?
}

struct CharacterList: Decodable {
  var available: Int?
  var returned: Int?
  var collectionURI: String
  var items: [CharacterSummary]
}

struct CharacterSummary: Decodable {
  var resourceURI: String?
  var name: String?
  var role: String?
}
