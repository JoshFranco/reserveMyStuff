//
//  JobUnitV2NetService.swift
//  Common
//
//  Created by Joshua Franco on 1/28/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import Foundation

enum JobUnitV2Router: NetworkRoutable {
  case getSpecifiedJobUnits(userId: Int, jobsIds: [Int])
  
  var type: Decodable.Type {
    switch self {
    case .getSpecifiedJobUnits:
      return String.self
    }
  }
  
  var baseURL: URL {
    NetworkingConstants.baseURL
  }
  
  var path: String {
    switch self {
    case .getSpecifiedJobUnits(let userId, _):
      return "v3/users/\(userId)/jobs"
    }
  }
  
  var query: [URLQueryItem]? {
    switch self {
    case .getSpecifiedJobUnits(_, let jobIds):
      let idStrArr = jobIds.map { "\($0)" }
      let jobIdArr = idStrArr.joined(separator: ",")
      
      return [URLQueryItem(name: "jid", value: "\(jobIdArr)"),
              URLQueryItem(name: "remove_schedule", value: "true")]
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getSpecifiedJobUnits:
      return .get
    }
  }
  
  var task: RequestTask {
    switch self {
    case .getSpecifiedJobUnits:
      return .requestPlain
    }
  }
  
  var headers: Headers? {
    return NetworkingConstants.headers
  }
  
  var parametersEncoding: ParametersEncoding {
    return .url
  }
}
