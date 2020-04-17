//
//  NetworkingConstants.swift
//  Common
//
//  Created by Joshua Franco on 1/28/20.
//  Copyright © 2020 Jobox. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    /// Base URL for our BE resources
    static let baseURL: URL = {
        guard let url = URL(string: baseURLString) else {
            preconditionFailure("Invalid base URL string: \(baseURLString)")
        }
        return url
    }()
    
    /// This flag will log Curl Requests in the console, defaults to on when testing in DEBUG
    static var enableCurlRequest: Bool {
        return true
    }
    
    /// Default Headers for all BE calls
    static var headers: [String: String] {
        return [:]
    }
    
    /// Default Session for all BE Calls
    /// Starting at iOS 11 the call will wait for the phone to have a internet connection before performing a call
    static let defaultSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20 // 20 sec
        config.waitsForConnectivity = true
        config.requestCachePolicy = .useProtocolCachePolicy
        config.urlCache = urlCache
        
        return URLSession(configuration: config)
    }()
}

// MARK: - Private Constants
private extension NetworkingConstants {
    /// Base URL string to build BaseURL
    static let baseURLString: String = {
        return "\(secureProtocol)\(domainName)/\(serverName)"
    }()
    
    /// Encryption Constant
    static let md5_salt = "?!?!?!"
    
    /// Default URL Cache for URL Sessions
    static let urlCache: URLCache = {
        let capacity = 50 * 1024 * 1024 // 52 MBs
        let urlCache = URLCache(memoryCapacity: capacity,
                                diskCapacity: capacity,
                                diskPath: nil)
        return urlCache
    }()
    
    /// Flag for if the base URL uses Https (99% of the time it should)
    static var usingHttps: Bool {
        return true
    }
    
    /// Secure URL String to build base URLs
    static var secureProtocol: String {
        return usingHttps ? "https://" : "http://"
    }
    
    /// Server Name to build base URLs
    static var serverName: String {
        return "?"
    }
    
    /// Server Domain Name to build base URLs
    static var domainName: String {
        return "?"
    }
    
    /// Creates a auth Token to send to the BE
    /// - Parameter timeStamp: bases auth token off of time stamp
    static func authorizationToken(timeStamp: Int) -> String {
        let timeStamp = timeStamp
        let salt = md5_salt
        let token = "?"
        let encryptedData = "\(token)\(timeStamp)\(salt)"
        
        return encryptedData
    }
}
