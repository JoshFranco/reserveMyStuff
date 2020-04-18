//
//  ReservationService.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

class ReservationService {
    static let shared = ReservationService()
    
    private let dataDuration: TimeInterval = 86400 * 2 // 2 day
    private var shouldUpdate: Bool {
        get {
            guard let lastUpdate = UserDefaults.standard.reservationOptionsLastUpdate else { return true }
            
            if (lastUpdate.timeIntervalSinceReferenceDate + dataDuration) > Date().timeIntervalSinceReferenceDate {
                return false
            } else {
                return true
            }
        }
    }
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Util Methods
    func getMostCurrentOptions(completion: @escaping (Result<[ReservationOption], Error>) -> Void) {
        if !shouldUpdate, let cachedOptions = loadOptions() {
            completion(.success(cachedOptions.options))
        } else {
            NetworkManager.shared.getReservationOptions { [weak self] result in
                switch result {
                case .success(let newOptions):
                    UserDefaults.standard.reservationOptionsLastUpdate = Date()
                    self?.saveOptions(newOptions)
                    completion(.success(newOptions.options))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: - Private Methods
private extension ReservationService {
    func saveOptions(_ options: ReservationOptions) {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(options) else { return }
        
        UserDefaults.standard.reservationOptionsData = encoded
    }
    
    func loadOptions() -> ReservationOptions? {
        let decoder = JSONDecoder()
        if let optionsData = UserDefaults.standard.reservationOptionsData {
            let cachedOptions = try? decoder.decode(ReservationOptions.self,
                                                    from: optionsData)
            return cachedOptions
        } else {
            return nil
        }
    }
}
