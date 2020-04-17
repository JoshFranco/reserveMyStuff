//
//  JXGoogleRouter.swift
//  Common
//
//  Created by Joshua Franco on 11/12/19.
//  Copyright © 2019 Jobox. All rights reserved.
//

import CoreLocation

enum JXGoogleRouter: NetworkRoutable, Mockable {
  var file: (String, Bundle?) {
    return ("GMDirectionsMock", nil)
  }
  
  case polylineRoute(originId: String, destinationId: String)
  
  //#error("ok so test this, we want the type defined by the net service!")
  var type: Decodable.Type {
    switch self {
    case .polylineRoute:
      return String.self
    }
  }
  
  var baseURL: URL {
    return URL(safeStr: "https://maps.googleapis.com/")
  }
  
  var path: String {
    switch self {
    case .polylineRoute:
      return "maps/api/directions/json"
    }
  }
  
  var query: [URLQueryItem]? {
    switch self {
    case .polylineRoute(let originId, let destinationId):
      return [URLQueryItem(name: "origin", value: "place_id:\(originId)"),
              URLQueryItem(name: "destination", value: "place_id:\(destinationId)"),
              URLQueryItem(name: "sensor", value: "true"),
              URLQueryItem(name: "mode", value: "driving"),
              URLQueryItem(name: "key", value: "JXConfiguration.googleAPIKey")]
    }
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var task: RequestTask {
    switch self {
    case .polylineRoute:
      return .requestPlain
    }
  }
  
  var headers: Headers? {
    return nil
  }
  
  var parametersEncoding: ParametersEncoding {
    return .json
  }
}
