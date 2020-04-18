//
//  NetworkManager.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

public class NetworkManager: QueueManageable {
    static let shared = NetworkManager()
    
    public internal(set) var queue: OperationQueue = OperationQueue()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Requests
    func getReservationOptions(completion: @escaping (Result<ReservationOptions, Error>) -> Void) {
        let optionsRonuter = ReservationOptionsRounter.getLatestOptions
        let optionsOperation = DecodableOperation(session: MockSession(), type: ReservationOptions.self, router: optionsRonuter)
        optionsOperation.onFinish = completion
        self.enqueue(optionsOperation)
    }
}
