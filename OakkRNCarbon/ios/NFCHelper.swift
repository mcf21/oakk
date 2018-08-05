//
//  NFCHelper.swift
//  OakkRN
//
//  Created by Marcel McFall on 4/8/18.
//  Copyright © 2018 Oakk. All rights reserved.

import Foundation
import CoreNFC

struct PredefinedParameters {
  static let estimoteNFCrecordType: String = "estimote.com:id"
  static let estimoteNFCpayloadType: String = "payload"
}

class NFCHelper: NSObject {
  
  static func extractNFCid(fromNDefMessages messages: [NFCNDEFMessage]) -> String? {
    for message in messages {
      for record in message.records {
        print(record.payload)
        let recordType = String(data: record.type, encoding: .utf8)
        if (PredefinedParameters.estimoteNFCrecordType == recordType) {
          return record.payload.hexString
        }
      }
    }
    return nil
  }
}
