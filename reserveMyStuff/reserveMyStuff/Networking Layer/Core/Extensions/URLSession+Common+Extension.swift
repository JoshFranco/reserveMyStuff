//
//  URLSession+Common+Extension.swift
//  Common
//
//  Created by Joshua Franco on 3/15/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProvidable {
  public func dataTask(using router: NetworkRoutable, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
    let request = URLRequest(router: router)
    defer { logRequest(request) }
    
    return dataTask(with: request, completionHandler: completionHandler)
  }
  
  public func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
    return dataTask(with: request, completionHandler: completionHandler)
  }
}
