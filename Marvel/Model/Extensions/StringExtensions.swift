//
//  StringExtensions.swift
//  Marvel
//
//  Created by Tristan Djahel on 14/06/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

extension String {
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
}
