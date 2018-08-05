//
//  Data+String.swift
//  OakkRN
//
//  Created by Marcel McFall on 4/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

import Foundation
extension Data {
  var hexString: String {
    return self.reduce("") { $0 + String(format: "%02x", $1)}
  }
}
