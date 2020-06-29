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
  private let comicFilter: UISegmentedControl
  private let dataSource: ComicDataSourceController
  private var selectedComicHandle: AnyCancellable?
  private var fetchComicsHandle: AnyCancellable?

  override func loadView() {
    view = comicHomeView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = ""
    comicHomeView.collectionView.dataSource = dataSource
    navigationItem.titleView = comicFilter
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

    comicFilter.backgroundColor = AppConstants.marvelColor
    comicFilter.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    comicFilter.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    comicFilter.selectedSegmentIndex = 0

    comicFilter.addTarget(self, action: #selector(comicFilterChanged), for: .valueChanged)
  }

  @objc private func comicFilterChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      dataSource.comicsTypeDisplayed = .New
    case 1:
      dataSource.comicsTypeDisplayed = .Future
    default:
      fatalError()
    }
    self.comicHomeView.collectionView.reloadData()
  }

  init() {
    comicHomeView = ComicHomeView()
    comicFilter = UISegmentedControl(items: ComicFilterCase.allCases.map { $0.rawValue.localized })
    dataSource = ComicDataSourceController()
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
