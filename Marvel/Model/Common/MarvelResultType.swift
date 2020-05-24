//
//  ResultAPI.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

protocol MarvelResultType {
  associatedtype DataType
  var data: DataType { get set }

  var code: Int? { get set }
  var status: String? { get set }
  var copyright: String? { get set }
  var attributionText: String? { get set }
  var attributionHtml: String? { get set }
  var etag: String? { get set }
}
