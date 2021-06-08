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
  private var marvelApiKeys: [String: String] {
    Bundle.main.object(forInfoDictionaryKey: "MarvelAPIKeys") as! [String: String]
  }

  private var publicKey: String {
    marvelApiKeys["Public"]!
  }
  private var privateKey: String {
    marvelApiKeys["Private"]!
  }

  private func getApiParametersAsQueryItems(limit: Int = 20, offset: Int = 0) -> [URLQueryItem] {
    let timeStamp = String(Date().timeIntervalSince1970)
    let hash = "\(timeStamp)\(privateKey)\(publicKey)".md5
    var queryItems = [URLQueryItem]()
    queryItems.append(URLQueryItem(name: "ts", value: timeStamp))
    queryItems.append(URLQueryItem(name: "apikey", value: publicKey))
    queryItems.append(URLQueryItem(name: "hash", value: hash))
    queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
    queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
    return queryItems
  }

  private var jsonDecoder: JSONDecoder {
    let _jsonDecoder = JSONDecoder()
    _jsonDecoder.dateDecodingStrategy = .iso8601
    return _jsonDecoder
  }

  // MARK: Search
  func fetchComics(containing: String, limit: Int = 20, offset: Int = 0) -> AnyPublisher<ComicDataContainer, Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/comics?")!
    var queryParams = getApiParametersAsQueryItems(limit: limit, offset: offset)
    queryParams.append(URLQueryItem(name: "titleStartsWith", value: containing))

    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: ComicDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data }
      .eraseToAnyPublisher()
  }

  func fetchCharacters(containing: String, limit: Int = 20, offset: Int = 0) -> AnyPublisher<CharacterDataContainer, Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/characters?")!
    var queryParams = getApiParametersAsQueryItems(limit: limit, offset: offset)
    queryParams.append(URLQueryItem(name: "nameStartsWith", value: containing))

    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: CharacterDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data }
      .eraseToAnyPublisher()
  }

  // MARK: Comic
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
    queryParams.append(URLQueryItem(name: "dateDescriptor", value: "thisWeek"))
    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: ComicDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data.results }
      .eraseToAnyPublisher()
  }

  // MARK: Characters
  func fetchSeries(from character: Character) -> AnyPublisher<[Series], Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/characters/\(character.id)/series")!
    let queryParams = getApiParametersAsQueryItems()
    urlComponents.queryItems = queryParams
    let urlRequest = URLRequest(url: urlComponents.url!)

    return URLSession.shared.dataTaskPublisher(for: urlRequest)
      .map { $0.data }
      .decode(type: SeriesDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data.results }
      .eraseToAnyPublisher()
  }

  func fetchCharacters(from series: Series) -> AnyPublisher<[Character], Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/series\(series.id)/characters")!
    let queryParams = getApiParametersAsQueryItems()
    urlComponents.queryItems = queryParams
    let urlRequest = URLRequest(url: urlComponents.url!)

    return URLSession.shared.dataTaskPublisher(for: urlRequest)
      .map { $0.data }
      .decode(type: CharacterDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data.results }
      .eraseToAnyPublisher()
  }
}
