//
//  QueueManageable.swift
//  Common
//
//  Created by Joshua Franco on 3/14/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import Foundation

protocol QueueManageable: class {
  var queue: OperationQueue { get set }
}

extension QueueManageable {
  /// Max Number of Concurrent Operation
  /// NSOperationQueueDefaultMaxConcurrentOperationCount (which is recommended and is its default)
  /// causes the system to set the maximum number of operations based on system conditions.
  var maxOperationCount: Int {
    get {
      return queue.maxConcurrentOperationCount
    } set {
      queue.maxConcurrentOperationCount = newValue
    }
  }
  
  /// A Boolean value indicating whether the queue is actively scheduling operations for execution.
  var isSuspended: Bool {
    get {
      return queue.isSuspended
    } set {
      queue.isSuspended = newValue
    }
  }
  
  /// Conveys ongoing progress for a given task to the user.
  var progress: Progress? {
    get {
      guard #available(iOS 13.0, *) else { return nil }
      
      return queue.progress
    }
  }
  
  /// Adds the specified operation to the queue.
  /// - Parameter operation: Operation to add
  func enqueue(_ operation: Operation) {
      queue.addOperation(operation)
  }
  
  /// Cancels all Operations
  func cancelAllOperations() {
    queue.cancelAllOperations()
  }
  
  /// Block to execute once all operations are finished
  /// - Parameter onFinish: block to execute
  func onFinishBlock(completion onFinish: @escaping () -> Void) {
    if #available(iOS 13.0, *) {
      queue.addBarrierBlock(onFinish)
    } else {
      onFinish()
    }
  }
}
