//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Tristan Djahel on 10/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import Combine

struct MarvelAPI {
  // MARK: Private functions
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

  private var jsonDecoder: JSONDecoder {
    let _jsonDecoder = JSONDecoder()
    _jsonDecoder.dateDecodingStrategy = .iso8601
    return _jsonDecoder
  }

  // MARK: Characters
  private func fetchManyCharaters(offset: Int, limit: Int, sub: PassthroughSubject<[Character], Error>) {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/characters")!
    var queryParams = getApiParametersAsQueryItems()
    queryParams.append(URLQueryItem(name: "offset", value: String(offset)))
    queryParams.append(URLQueryItem(name: "limit", value: String(limit)))
    queryParams.append(URLQueryItem(name: "orderBy", value: "name"))
    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)

    URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        sub.send(completion: .failure(error))
      } else if let data = data {
        do {
          let characters = try self.jsonDecoder.decode(CharacterDataWrapper.self, from: data)
          let count = characters.data.count
          sub.send(characters.data.results)
          if characters.data.offset + count < characters.data.total {
            self.fetchManyCharaters(offset: offset + count, limit: limit, sub: sub)
          } else {
            sub.send(completion: .finished)
          }
        } catch {
          sub.send(completion: .failure(error))
        }
      }
    }.resume()
  }

  func fetchAllCharacters() -> AnyPublisher<[Character], Error> {
    let sub = PassthroughSubject<[Character], Error>()
    fetchManyCharaters(offset: 0, limit: 100, sub: sub)
    return sub.eraseToAnyPublisher()
  }

  // MARK: Comic
  private func handleComicResult(_ data: Data, _ completion: (Result<[Comic], Error>) -> Void) throws {
    let result: ComicDataWrapper = try self.jsonDecoder.decode(ComicDataWrapper.self, from: data)
    if result.code == 200 {
      completion(.success(result.data.results))
    } else {
      throw URLError(URLError.Code(rawValue: result.code))
    }
  }

  func fetchAboutToBePublishedComics() -> AnyPublisher<[Comic], Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/comics?")!
    var queryParams = getApiParametersAsQueryItems()
    queryParams.append(URLQueryItem(name: "dateDescriptor", value: "nextWeek"))
    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: ComicDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data.results }
      .eraseToAnyPublisher()
  }

  func fetchNewlyPublishedComics() -> AnyPublisher<[Comic], Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/comics?")!
    var queryParams = getApiParametersAsQueryItems()
    queryParams.append(URLQueryItem(name: "dateDescriptor", value: "thisMonth"))
    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: ComicDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data.results }
      .eraseToAnyPublisher()
  }
}
