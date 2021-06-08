//
//  ComicHomeListViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 27/05/2021.
//  Copyright © 2021 Tristan Djahel. All rights reserved.
//

import UIKit
import Combine

class ComicHomeListViewController: UIViewController {

  private let comicHomeView: ComicHomeView
  private(set) var dataSource: ComicDataSourceController
  private var fetchComicsHandle: AnyCancellable?
  private var selectedComicHandle: AnyCancellable?

  override func loadView() {
    view = comicHomeView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    comicHomeView.collectionView.dataSource = dataSource
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
      let comic = self.dataSource.getComicsFromFilter()[indexPath.row]
      self.navigationController?.pushViewController(ComicDetailViewController(comic), animated: true)
    })
  }

  init(comicType: ComicFilterCase) {
    comicHomeView = ComicHomeView()
    dataSource = ComicDataSourceController()
    dataSource.comicsTypeDisplayed = comicType
    super.init(nibName: nil, bundle: nil)
    switch dataSource.comicsTypeDisplayed {
    case .New:
      navigationItem.title = "comics_new".localized
    case .Future:
      navigationItem.title = "comics_to_come".localized
    }
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
