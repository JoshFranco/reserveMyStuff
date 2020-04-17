//
//  URLRequest+JX+Extension.swift
//  Common
//
//  Created by Joshua Franco on 11/12/19.
//  Copyright © 2019 Jobox. All rights reserved.
//

import Foundation

extension URLRequest {
  /// Creates a request based off of a service protocol
  /// - Parameter service: protocol to create a URL Request out off
  init(router: NetworkRoutable) {
    let urlComponents = URLComponents(router: router)
    
    self.init(url: urlComponents.url!)
    
    self.httpMethod = router.method.rawValue
    router.headers?.forEach { self.addValue($1, forHTTPHeaderField: $0) }
    
    switch router.task {
    case .requestParameters(let param) where router.parametersEncoding == .json:
      self.httpBody = try? JSONSerialization.data(withJSONObject: param)
    case .requestData(let data) where router.parametersEncoding != .json:
      self.httpBody = data
    default: break
    }
  }
}
