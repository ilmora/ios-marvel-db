//
//  SeeMoreComicsViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 15/08/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SeeMoreComicsViewController: UIViewController {
  private let comics: [Comic]

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  init(comics: [Comic]) {
    self.comics = comics
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
