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
  private let dataSource: ComicDataSourceController
  private var selectedComicHandle: AnyCancellable?
  private var fetchComicsHandle: AnyCancellable?

  override func loadView() {
    view = comicHomeView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    comicHomeView.collectionView.dataSource = self.dataSource
    fetchComicsHandle = dataSource.$newComics
      .merge(with: dataSource.$futureComics)
      .sink(receiveValue: { _ in
        DispatchQueue.main.async {
          self.comicHomeView.collectionView.reloadData()
        }
      })
    dataSource.fetchData()
    selectedComicHandle = comicHomeView.$selectedCellIndex.sink(receiveValue: { indexPath in
      guard let indexPath = indexPath else {
        return
      }
      let comic: Comic
      switch indexPath.section {
      case AppConstants.ComicSection.newComics:
        comic = self.dataSource.newComics[indexPath.row]
      case AppConstants.ComicSection.futureComics:
        comic = self.dataSource.futureComics[indexPath.row]
      default:
        fatalError()
      }
      self.navigationController?.pushViewController(ComicDetailViewController(comic), animated: true)
    })
  }

  init() {
    comicHomeView = ComicHomeView()
    dataSource = ComicDataSourceController()
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
