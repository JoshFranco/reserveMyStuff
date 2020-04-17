//
//  JXNetworkManager.swift
//  Common
//
//  Created by Joshua Franco on 3/13/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import Foundation

public class JXNetworkManager: QueueManageable {
  static let shared = JXNetworkManager()
  
  public internal(set) var queue: OperationQueue = OperationQueue()
  
  // MARK: - Init
  private init() {
  }
}

// MARK: - Internal Methods
internal extension JXNetworkManager {
}

// MARK: Private Methods
private extension JXNetworkManager {
}
