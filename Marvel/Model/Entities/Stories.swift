//
//  Stories.swift
//  Marvel
//
//  Created by Tristan Djahel on 04/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct StoriesDataWrapper: MarvelResultType, Decodable {
  var data: StoriesDataContainer
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
}

struct StoriesDataContainer: MarvelResultType, Decodable {
  var data: Stories
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
}

struct Stories: Decodable, Identifiable {
  var id: Int
  var title: String
  var description: String
}
