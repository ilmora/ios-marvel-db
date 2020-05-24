//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Tristan Djahel on 10/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation

struct MarvelAPI {
  private let publicKey = "publickey"
  private let privateKey = "privatekey"

  private func getApiParametersAsQueryItems() -> [URLQueryItem] {
    let timeStamp = String(Date().timeIntervalSince1970)
    let hash = "\(timeStamp)\(privateKey)\(publicKey)".md5
    var queryItems = [URLQueryItem]()
    queryItems.append(URLQueryItem(name: "ts", value: timeStamp))
    queryItems.append(URLQueryItem(name: "apikey", value: publicKey))
    queryItems.append(URLQueryItem(name: "hash", value: hash))
    return queryItems
  }

  func fetchComics(completion: @escaping (Result<[Comic], Error>) -> Void) {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/comics?")!
    var queryParams = getApiParametersAsQueryItems()
    queryParams.append(URLQueryItem(name: "dateDescriptor", value: "thisWeek"))
    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        do {
          let result: ComicDataWrapper = try JSONDecoder().decode(ComicDataWrapper.self, from: data)
          if result.code == 200 {
            completion(.success(result.data.results!))
          }
        } catch {
          completion(.failure(error))
        }
      }
    }.resume()
  }
}
