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
  private(set) var dataSourceController: ComicDataSourceController
  private var fetchComicsHandle: AnyCancellable?
  private var selectedComicHandle: AnyCancellable?

  private lazy var dataSource = dataSourceController.makeDataSource()

  override func loadView() {
    view = comicHomeView
  }

  @objc private func reloadComicList() {
    fetchComicsHandle = dataSourceController.$newComics
      .merge(with: dataSourceController.$futureComics)
      .sink(receiveValue: { _ in
        DispatchQueue.main.async {
          self.dataSource.apply(self.dataSourceController.makeSnapshot(), animatingDifferences: true)
          self.comicHomeView.collectionView.refreshControl?.endRefreshing()
        }
      })
    dataSourceController.fetchData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    comicHomeView.collectionView.refreshControl = UIRefreshControl()
    comicHomeView.collectionView.refreshControl?.attributedTitle = NSAttributedString(string: "Reloading".localized)
    comicHomeView.collectionView.refreshControl?.addTarget(self, action: #selector(reloadComicList), for: .valueChanged)
    reloadComicList()
    selectedComicHandle = comicHomeView.$selectedCellIndex.sink(receiveValue: { indexPath in
      guard let indexPath = indexPath else {
        return
      }
      let comic = self.dataSourceController.getComicsFromFilter()[indexPath.row]
      self.navigationController?.pushViewController(ComicDetailViewController(comic), animated: true)
    })
  }

  init(comicType: ComicFilterCase) {
    comicHomeView = ComicHomeView()
    dataSourceController = ComicDataSourceController(comicHomeView.collectionView)
    dataSourceController.comicsTypeDisplayed = comicType
    super.init(nibName: nil, bundle: nil)
    switch dataSourceController.comicsTypeDisplayed {
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
