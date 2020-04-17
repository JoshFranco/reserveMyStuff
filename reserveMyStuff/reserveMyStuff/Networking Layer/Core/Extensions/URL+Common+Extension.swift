//
//  URL+Common+Extension.swift
//  Common
//
//  Created by Joshua Franco on 11/13/19.
//  Copyright © 2019 Jobox. All rights reserved.
//

import Foundation

extension URL {
  /// Use this method to get a non-optional URL. NOTE: if it fails the app wil crash
  /// - Parameter safeStr: URL string that will be converted into a URL
  init(safeStr: String) {
    guard let url = URL(string: safeStr) else { fatalError("Unconstructable URL: \(safeStr)") }
    
    self = url
  }
}
