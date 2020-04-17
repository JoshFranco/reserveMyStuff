//
//  EmptyOperation.swift
//  Common
//
//  Created by Joshua Franco on 3/13/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import Foundation

class EmptyOperation: Operable<Void> {
  init(session: URLSessionProvidable = NetworkingConstants.defaultSession, service: NetworkRoutable) {
    super.init()
    
    self.session = session
    self.router = service
  }
  
  override func requestWithRetry(with router: NetworkRoutable, retry attempts: Int, delay interval: TimeInterval, isOverridden: Bool = true) {
    super.requestWithRetry(with: router, retry: attempts, delay: interval)
    
    task = session?.dataTask(using: router, completionHandler: { [weak self] data, response, error in
      guard let self = self else { return }
      
      let httpResponse = response as? HTTPURLResponse
      self.handleDataResponse(data: data, response: httpResponse, error: error) { (result: Result<Void, Error>) in
        switch result {
        case .success:
          self.complete(with: result)
        case .failure where attempts > 0:
          DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + interval) {
            let updatedAttempts = attempts - 1
            let updatedDelay = interval * 2
            self.requestWithRetry(with: router, retry: updatedAttempts, delay: updatedDelay)
          }
        case .failure(let error):
          self.complete(with: .failure(error))
        }
      }
    })
    
    task?.resume()
  }
  
  func handleDataResponse(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (Result<Void, Error>) -> ()) {
    guard error == nil else { return completion(.failure(error!)) }
    guard let response = response else { return completion(.failure(NetworkError.noJsonData)) }
    
    switch response.statusCode {
    case 200...299:
      guard data != nil else { return completion(.failure(NetworkError.badData)) }
      completion(.success(()))
    default:
      completion(.failure(NetworkError.badStatusCode(code: response.statusCode)))
    }
  }
}
