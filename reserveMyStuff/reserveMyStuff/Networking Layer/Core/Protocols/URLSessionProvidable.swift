//
//  URLSessionProvidable.swift
//  Common
//
//  Created by Joshua Franco on 11/12/19.
//  Copyright © 2019 Jobox. All rights reserved.
//

import Foundation

// configurable URLSessionDataTask for future testing
public protocol URLSessionProvidable {
  typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
  func dataTask(using router: NetworkRoutable, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSessionProvidable {
  func logRequest(_ request: URLRequest) {
    guard NetworkingConstants.enableCurlRequest else { return }
    
    #warning("make a comment here")
    print(request)
  }
}
