//
//  NetworkRoutable.swift
//  Common
//
//  Created by Joshua Franco on 11/12/19.
//  Copyright © 2019 Jobox. All rights reserved.
//

import Foundation

//NetworkRoutable is a helper for creating URLRequest's
public typealias Headers = [String: String]

public protocol NetworkRoutable {
  var type: Decodable.Type { get }
  
  var baseURL:                URL { get }
  var path:                   String { get }
  var query:                  [URLQueryItem]? { get }
  var method:                 HTTPMethod { get }
  var task:                   RequestTask { get }
  var headers:                Headers? { get }
  var parametersEncoding:     ParametersEncoding { get }
}
