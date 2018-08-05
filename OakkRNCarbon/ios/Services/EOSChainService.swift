//
//  EOSChainService.swift
//  OakkRN
//
//  Created by Marcel McFall on 4/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

import Foundation
enum RequestType:String {
  case get = "GET"
  case post = "POST"
}
enum HTTPHeaderField: String {
  case contentType = "Content-Type"
  case accept = "Accept"
}
enum HTTPResponseType:String {
  case json = "applicatiovarson"
  case plain = "text/plain; charset=utf-8"
}

protocol EOSProtocol {
  var urlSession: URLSession? { get }
  func createRequestBody(using postParams:[String: String]) -> Data?
  func generateRequest(forType requestType: RequestType, using url: String) -> URLRequest?
}
class EOSChainService: NSObject, EOSProtocol {
  func createRequestBody(using postParams:[String: String]) -> Data? {
    let JSON = try? JSONSerialization.data(withJSONObject: postParams, options: [])
    return JSON
  }
  
  func generateRequest(forType requestType: RequestType, using url: String) -> URLRequest? {
    guard let url = NSURL(string: url) else { return nil }
    var request:URLRequest = URLRequest(url: url as URL)
    request.httpMethod = "POST"
    request.addValue(HTTPResponseType.plain.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    request.addValue(HTTPResponseType.plain.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
    return request
  }
  var urlSession: URLSession? {
    let urlConfig = URLSessionConfiguration.default
    urlConfig.timeoutIntervalForRequest = 30
    return URLSession(configuration: urlConfig)
  }
  func getBlockChainInfo(completionBlock: @escaping (EOSBlockStatus?) -> Void) {
    guard let request = generateRequest(forType: .post, using: "http://localhost:8888/v1/chain/get_info"), let session = urlSession else {
      completionBlock(nil)
      return
    }
    let task = session.dataTask(with: request) { (data, response, error) in
      let eOSBlockStatus = try? JSONDecoder().decode(EOSBlockStatus.self, from: data!)
      completionBlock(eOSBlockStatus)
      return
    }
    task.resume()
  }
  
  func getTreeBlockInfo(forTreeId treeId: String, completionBlock: @escaping (Row?) -> Void) {
    guard var request = generateRequest(forType: .post, using: "http://172.16.96.204:8888/v1/chain/get_table_rows"), let session = urlSession else {
      completionBlock(nil)
      return
    }
    
    let json = ["scope": "trees","code": "trees","table": "trees","json": true] as [String : Any]
    let jsonStr = try! JSONSerialization.data(withJSONObject: json, options: [])
    request.httpBody = try! JSONSerialization.data(withJSONObject: json, options: [])
    print("request body ==", request.httpBody)
    let task = session.dataTask(with: request.url!) { (data, response, error) in
      print("response == " ,String(data: data!, encoding: .utf8))
      let eOSTableRow = try? JSONDecoder().decode(EOSTableRow.self, from: data!)
      let treeInfo = eOSTableRow?.rows.filter { $0.trackerId == "thisisanotherstring"}.map { return $0 }
      completionBlock(treeInfo?.first)
      return
    }
    task.resume()
  }
}
extension RequestType: CustomStringConvertible {
  var description: String {
    return rawValue
  }
}
protocol URLQueryParameterStringConvertible {
  var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
  var queryParameters: String {
    var parts: [String] = []
    for (key, value) in self {
      let part = String(format: "%@=%@",
                        String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                        String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
      parts.append(part as String)
    }
    return parts.joined(separator: "&")
  }
  
}
