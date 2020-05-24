//
//  ComicDetailViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 23/05/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class ComicDetailViewController: UIViewController {
  private let comicDetailView: ComicDetailView
  private let viewModel: ComicDetailViewModel

  override func loadView() {
    view = comicDetailView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  init(_ comic: Comic) {
    viewModel = ComicDetailViewModel()
    viewModel.comic = comic
    comicDetailView = ComicDetailView(viewModel)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
