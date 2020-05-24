//
//  ViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 10/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import UIKit
import Combine

class ComicHomeViewController: UIViewController {
  private let comicHomeView: ComicHomeView

  private var selectedComicHandle: AnyCancellable?
  private var selectedComicFilterHandle: AnyCancellable?

  private let api = MarvelAPI()
  private let viewModel: ComicHomeViewModel

  private let comicFilters = ComicFilter.allCases

  override func loadView() {
    view = comicHomeView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    selectedComicHandle = viewModel.$selectedComic.sink(receiveCompletion: { _ in
      self.selectedComicHandle = nil
    }, receiveValue: { selectedComic in
      if let selectedComic = selectedComic {
        self.navigationController?.pushViewController(ComicDetailViewController(selectedComic), animated: true)
      }
    })
    selectedComicFilterHandle = viewModel.$selectedComicFilter.sink(receiveCompletion: {_ in
      self.selectedComicFilterHandle = nil
    }, receiveValue: { newSelectedComicFilter in
      guard let newFilterAsEnum = ComicFilter(rawValue: newSelectedComicFilter) else {
        self.selectedComicFilterHandle = nil
        return
      }
      print(newFilterAsEnum)
      switch newFilterAsEnum {
      case .new:
        self.api.fetchComics(completion: { comicsResult in
          switch comicsResult {
          case .success(let comics):
            self.viewModel.comics = comics
          case .failure(let error):
            print(error.localizedDescription)
          }
        })
      case .free:
        self.viewModel.comics.removeAll()
      }
    })

    self.viewModel.comicsFilter = self.comicFilters.map { $0.rawValue }
    //self.viewModel.selectedComicFilter = comicFilters.first!.rawValue
  }

  init() {
    self.viewModel = ComicHomeViewModel()
    self.comicHomeView = ComicHomeView(viewModel)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
