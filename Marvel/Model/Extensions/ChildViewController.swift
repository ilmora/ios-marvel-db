//
//  ChildViewController.swift
//  Marvel
//
//  Created by Tristan Djahel on 09/09/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }

  func remove() {
    guard parent != nil else {
      return
    }
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }

  var topbarHeight: CGFloat {
    return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
      (self.navigationController?.navigationBar.frame.height ?? 0.0)
  }
}

extension UIView {
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder?.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}
