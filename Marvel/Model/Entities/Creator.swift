//
//  Creator.swift
//  Marvel
//
//  Created by Tristan Djahel on 04/07/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct CreaterDataWrapper: MarvelResultType, Decodable {
  var code: Int
  var status: String
  var copyright: String
  var attributionText: String
  var attributionHtml: String?
  var etag: String
  var data: CreatorDataContainer
}

struct CreatorDataContainer: MarvelDataContainer, Decodable {
  var offset: Int
  var limit: Int
  var total: Int
  var count: Int
  var results: [Creator]
}

struct Creator: Decodable, Identifiable {
  var id: Int
  var firstName: String
  var middleName: String
  var lastName: String
  var suffix: String
  var fullName: String
}
