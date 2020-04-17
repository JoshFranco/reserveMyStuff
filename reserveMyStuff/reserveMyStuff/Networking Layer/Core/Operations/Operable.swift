//
//  Operable.swift
//  Common
//
//  Created by Joshua Franco on 3/3/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import UIKit

public class Operable<T>: Operation {
  /// Current State of the Operation
  private var state = State.ready {
      willSet {
          willChangeValue(forKey: newValue.rawValue)
          willChangeValue(forKey: state.rawValue)
      }
      didSet {
          didChangeValue(forKey: oldValue.rawValue)
          didChangeValue(forKey: state.rawValue)
      }
  }
  
  /// Result of Operation when its finished
  public var onFinish: ((Result<T, Error>) -> Void)?
  /// Commonly a URLSession but could be mocked for testing
  public var session: URLSessionProvidable?
  
  public var task: URLSessionTask?
  public var router: NetworkRoutable?
  
  public var baseDelay: TimeInterval = 1
  public var retryAttempts: Int = 3
  public var priority: Operation.QueuePriority = .normal {
    didSet {
      self.queuePriority = priority
    }
  }
  
  // MARK: - Override Var's
  public override var isReady: Bool {
      return super.isReady && state == .ready
  }
  
  public override var isExecuting: Bool {
      return state == .executing
  }
  
  public override var isFinished: Bool {
      return state == .finished
  }
  
  // MARK: - Overrides
  public override func main() {
    guard let router = router else { return }
    
    requestWithRetry(with: router,
                     retry: retryAttempts,
                     delay: baseDelay,
                     isOverridden: false)
  }
  
  public override func start() {
      guard !isCancelled else {
          finish()
          return
      }
      
      if !isExecuting {
          state = .executing
      }
      
      main()
  }
  
  public override func cancel() {
    task?.cancel()
    onFinish?(.failure(NetworkError.requestedCanceled))
    super.cancel()
  }
  
  // MARK: - Internal Methods
  /// API request, if it fails it will attempt to retry based on operation var's
  /// - Parameters:
  ///   - router: Router to bulid request, enum that is NetworkRoutable
  ///   - attempts: Number of attempts if the call fails
  ///   - interval: delay between retrys, this is exponential ex: 1sec, 2sec, 4sec
  ///   - isOverridden: if method is overridden, if the method is not overridden the task will atuo fail
  func requestWithRetry(with router: NetworkRoutable, retry attempts: Int, delay interval: TimeInterval, isOverridden: Bool = true) {
    let request = URLRequest(router: router)
    logRequest(request)
    
    if !isOverridden {
      self.cancel()
    }
  }
}

// MARK: Public Methods
public extension Operable {
  /// Complete Operation based on state
  /// - Parameter result: result of the operation
  func complete(with result: Result<T, Error>) {
      finish()
  
      if !isCancelled {
          onFinish?(result)
      } else {
        onFinish?(.failure(NetworkError.requestedCanceled))
    }
  }
}

// MARK: - Private Methods
private extension Operable {
  enum State: String {
      case ready = "isReady"
      case executing = "isExecuting"
      case finished = "isFinished"
  }
  
  func finish() {
      if isExecuting {
          state = .finished
      }
  }
  
  func logRequest(_ request: URLRequest) {
    guard NetworkingConstants.enableCurlRequest else { return }
    
    #warning("add comments here about logging!!! ALSO THERE ARE TWO LOGGERS PICK ONE")
    print(request)
  }
}
