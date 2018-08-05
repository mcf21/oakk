//
//  EOSTableRow.swift
//  OakkRN
//
//  Created by Marcel McFall on 5/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//
//   let eOSTableRow = try? JSONDecoder().decode(EOSTableRow.self, from: jsonData)

import Foundation

struct EOSTableRow: Codable {
  let rows: [Row]
  let more: Bool
}

struct Row: Codable {
  let id, treetype: Int
  let planter: String
  let trackerId: String
  let completed, createdAt: Int
  
  enum CodingKeys: String, CodingKey {
    case id, treetype, planter, completed
    case createdAt = "created_at"
    case trackerId = "trackerid"
  }
}
