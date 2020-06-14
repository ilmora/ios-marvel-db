//
//  Reusable.swift
//  Marvel
//
//  Created by Tristan Djahel on 11/04/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable {
  static var reusableIdentifier: String { get }
}

extension UICollectionReusableView: Reusable {
  static var reusableIdentifier: String {
    String(describing: self)
  }
}

extension UITableViewCell: Reusable {
  static var reusableIdentifier: String {
    String(describing: self)
  }
}
