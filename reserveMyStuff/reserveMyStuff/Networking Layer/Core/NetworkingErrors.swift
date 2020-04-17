//
//  NetworkingErrors.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case notMockable
    case fileNotFound
    case requestedCanceled
    case noJsonData
    case badData
    case badStatusCode(code: Int)
    
}

extension NetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .notMockable:
        return "This Router is does not conform to Mockable"
    case .fileNotFound:
        return "File was not found"
    case .requestedCanceled:
        return "Request was cancelded by the manager"
    case .noJsonData:
        return "No JSON Data"
    case .badData:
        return "Could not read data"
    case .badStatusCode(let code):
        return "Bad Status Code: \(code)"
    }
  }
}
