//
//  ReservationOptionsRounter.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

enum ReservationOptionsRounter: NetworkRoutable, Mockable {
    case getLatestOptions
    
    var file: (String, Bundle?) {
        return ("ReservationOptionsMock", nil)
    }
    
    var type: Decodable.Type {
        switch self {
        case .getLatestOptions:
            return [ReservationOption].self
        }
    }
    
    var baseURL: URL {
        return NetworkingConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getLatestOptions:
            return "???"
        }
    }
    
    var query: [URLQueryItem]? {
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLatestOptions:
            return .get
        }
    }
    
    var task: RequestTask {
        switch self {
        case .getLatestOptions:
            return .requestPlain
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
