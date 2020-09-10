//
//  SeeMoreButton.swift
//  Marvel
//
//  Created by Tristan Djahel on 15/08/2020.
//  Copyright © 2020 Tristan Djahel. All rights reserved.
//

import Foundation
import UIKit

class SeeMoreButton: UIButton {

  var targetEntity: SearchEntitiesSection?

  init() {
    super.init(frame: .zero)
    setTitle("SeeMore".localized, for: .normal)
    setTitleColor(.systemGray, for: .normal)
    backgroundColor = .clear
    layer.borderColor = UIColor.systemGray3.cgColor
    layer.borderWidth = 2
    layer.cornerRadius = 10
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
