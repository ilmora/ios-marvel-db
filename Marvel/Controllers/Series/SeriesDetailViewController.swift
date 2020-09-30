//
// Created by Tristan Djahel on 16/09/2020.
// Copyright (c) 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SeriesDetailViewController: UIViewController {
  private let seriesDetailView: SeriesDetailView
  private let series: Series

  override func viewDidLoad() {
    super.viewDidLoad()
    seriesDetailView.label.text = "ALLO"
  }

  override func loadView() {
    view = seriesDetailView
  }

  init(series: Series) {
    seriesDetailView = SeriesDetailView()
    self.series = series
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
