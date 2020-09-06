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

  // MARK: Search
  private func fetchComics(containing: String) -> AnyPublisher<[Comic], Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/comics?")!
    var queryParams = getApiParametersAsQueryItems()
    queryParams.append(URLQueryItem(name: "titleStartsWith", value: containing))

    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: ComicDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data.results }
      .eraseToAnyPublisher()
  }

  private func fetchCharacters(containing: String) -> AnyPublisher<[Character], Error> {
    var urlComponents = URLComponents(string: "https://gateway.marvel.com/v1/public/characters?")!
    var queryParams = getApiParametersAsQueryItems()
    queryParams.append(URLQueryItem(name: "nameStartsWith", value: containing))

    urlComponents.queryItems = queryParams
    let request = URLRequest(url: urlComponents.url!)
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: CharacterDataWrapper.self, decoder: jsonDecoder)
      .map { $0.data.results }
      .eraseToAnyPublisher()
  }

  func fetchEntities(containing text: String) -> (AnyPublisher<[Comic], Error>, AnyPublisher<[Character], Error>) {
    let comicsPublisher = fetchComics(containing: text)
    let charactersPublisher = fetchCharacters(containing: text)

    return (comicsPublisher, charactersPublisher)
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
}
