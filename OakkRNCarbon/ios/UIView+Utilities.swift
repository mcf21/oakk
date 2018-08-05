//
//  UIView+Utilities.swift
//  OakkRN
//
//  Created by Marcel McFall on 5/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

import Foundation
extension UIView {
  func applyGradient(colors: [UIColor]) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors.map({ return $0.cgColor})
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 0, y: 0)
    gradientLayer.frame = self.bounds
    gradientLayer.zPosition = -1
    self.layer.addSublayer(gradientLayer)
  }
}
