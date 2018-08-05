//
//  EOSBlockStatus.swift
//  OakkRN
//
//  Created by Marcel McFall on 4/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

import Foundation
struct EOSBlockStatus: Codable {
  let serverVersion, chainID: String
  let headBlockNum, lastIrreversibleBlockNum: Int
  let lastIrreversibleBlockID, headBlockID, headBlockTime, headBlockProducer: String
  let virtualBlockCPULimit, virtualBlockNetLimit, blockCPULimit, blockNetLimit: Int
  
  enum CodingKeys: String, CodingKey {
    case serverVersion = "server_version"
    case chainID = "chain_id"
    case headBlockNum = "head_block_num"
    case lastIrreversibleBlockNum = "last_irreversible_block_num"
    case lastIrreversibleBlockID = "last_irreversible_block_id"
    case headBlockID = "head_block_id"
    case headBlockTime = "head_block_time"
    case headBlockProducer = "head_block_producer"
    case virtualBlockCPULimit = "virtual_block_cpu_limit"
    case virtualBlockNetLimit = "virtual_block_net_limit"
    case blockCPULimit = "block_cpu_limit"
    case blockNetLimit = "block_net_limit"
  }
}
