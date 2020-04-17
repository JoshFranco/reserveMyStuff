//
//  MockSession.swift
//  Common
//
//  Created by Joshua Franco on 3/15/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import Foundation

class MockSession: URLSessionProvidable {
  func dataTask(using router: NetworkRoutable, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
    guard let mockableRouter = router as? Mockable else {
        defer { completionHandler(nil, nil, NetworkError.notMockable) }
      return URLSessionDataTask()
    }
    
    defer {
      let (resourceStr, bundle) = mockableRouter.file
      
      if let fileUrl = (bundle ?? Bundle(for: MockSession.self)).url(forResource: resourceStr, withExtension: "json") {
        let fileData = try? Data(contentsOf: fileUrl)
        let response = HTTPURLResponse(url: fileUrl,
                                       statusCode: fileData != nil ? 200: 500,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        completionHandler(fileData, response, nil)
      } else {
        completionHandler(nil, nil, NetworkError.fileNotFound)
      }
    }
    
    return URLSessionDataTask()
  }
}
