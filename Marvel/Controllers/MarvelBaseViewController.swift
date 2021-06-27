//
//  MarvelBaseViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 27/06/2021.
//  Copyright © 2021 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class MarvelBaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.tintColor = AppConstants.marvelColor
  }
}
