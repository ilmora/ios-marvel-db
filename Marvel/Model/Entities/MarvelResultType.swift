//
//  ResultAPI.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

protocol MarvelResultType {
  associatedtype DataWrapper
  var data: DataWrapper { get set }

  var code: Int { get set }
  var status: String { get set }
  var copyright: String { get set }
  var attributionText: String { get set }
  var attributionHtml: String? { get set }
  var etag: String { get set }
}

protocol MarvelDataContainer {
  associatedtype DataContainer
  var offset: Int { get set }
  var limit: Int { get set }
  var total: Int { get set }
  var count: Int { get set }
  var results: [DataContainer] { get set }
}

protocol EntityList {
  var available: Int? { get set }
  var returned: Int? { get set }
  var collectionURI: String? { get set }
  associatedtype EntityType
  var items: [EntityType]? { get set }
}

protocol EntitySummary {
  var resourceURI: String? { get set }
  var name: String? { get set }
}

protocol MarvelErrorType {
  var code: Int { get set }
  var status: String { get set }
}

struct MarvelError: MarvelErrorType, Error {
  var code: Int
  var status: String
}
