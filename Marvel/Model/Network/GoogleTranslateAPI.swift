//
// Created by Tristan Djahel on 14/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import Combine

struct GoogleTranslateAPI {
  private var apiKey: String {
    Bundle.main.object(forInfoDictionaryKey: "GoogleTranslateApiKey") as! String
  }

  func translate(characterDetailDescription: String) -> AnyPublisher<String, Error> {
    var url = URLComponents(string: "https://translation.googleapis.com/language/translate/v2")!
    var queryParams = [URLQueryItem]()
    queryParams.append(URLQueryItem(name: "q", value: characterDetailDescription))
    queryParams.append(URLQueryItem(name: "target", value: "fr"))
    queryParams.append(URLQueryItem(name: "key", value: apiKey))

    url.queryItems = queryParams

    return URLSession.shared.dataTaskPublisher(for: url.url!)
    .map { $0.data }
    .tryMap( { data in
      let root = try JSONSerialization.jsonObject(with: data) as! [String: Any]
      let data = root["data"] as! [String: Any]
      let translations = data["translations"] as! [[String: Any]]
      return (translations.first!["translatedText"] as! String)
              .replacingOccurrences(of: "&#39;", with: "'")
    })
    .eraseToAnyPublisher()
  }
}