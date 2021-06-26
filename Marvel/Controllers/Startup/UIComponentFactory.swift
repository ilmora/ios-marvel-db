//
//  UIComponentFactory.swift
//  Marvel
//
//  Created by Tristan Djahel on 24/06/2021.
//  Copyright © 2021 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

struct UIComponentFactory {

  func marvelNavigationController(rootVC: UIViewController) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: rootVC)
    return navigationController
  }
}
