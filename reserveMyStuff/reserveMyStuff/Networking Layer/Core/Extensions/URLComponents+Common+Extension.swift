//
//  URLComponents+Common+Extension.swift
//  Common
//
//  Created by Joshua Franco on 11/12/19.
//  Copyright © 2019 Jobox. All rights reserved.
//

import Foundation

extension URLComponents {
  /// Init for URL componenets based off of a service protocol
  /// - Parameter service: protocol the URL Components is bassed off of
  init(router: NetworkRoutable) {
    var url = router.baseURL.appendingPathComponent(router.path)
    
    if let queryItems = router.query, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
      urlComponents.queryItems = queryItems
      url = urlComponents.url ?? url
    }
    
    self.init(url: url, resolvingAgainstBaseURL: false)!
    
    switch router.task {
    case .requestParameters(let param) where router.parametersEncoding == .url:
      self.queryItems = param.map { URLQueryItem(name: $0, value: String(describing: $1)) }
    default: break
      
    }
  }
}
