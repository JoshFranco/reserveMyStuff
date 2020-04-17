//
//  Task.swift
//  Common
//
//  Created by Joshua Franco on 11/12/19.
//  Copyright © 2019 Jobox. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

// Task is an enum responsible for configuring parameters for a specific service
// more ex: upload(Data), download(parameters: Parameters)
public enum RequestTask {
  case requestPlain
  case requestParameters(Parameters)
  case requestData(Data)
}
