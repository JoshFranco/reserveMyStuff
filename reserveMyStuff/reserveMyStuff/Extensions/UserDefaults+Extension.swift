//
//  UserDefaults+Extension.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

extension UserDefaults {
    private enum keys: String {
        case reservationOptionsLastUpdate = "reservation_options_last_update"
        case reservationData = "reservation_data"
    }
    
    var reservationOptionsLastUpdate: Date? {
        get {
            let lastUpdateInterval: TimeInterval = UserDefaults.standard.double(forKey: keys.reservationOptionsLastUpdate.rawValue)
            return Date(timeIntervalSinceReferenceDate: lastUpdateInterval)
        } set {
            let refDate = newValue?.timeIntervalSinceReferenceDate
            UserDefaults.standard.set(refDate, forKey: keys.reservationOptionsLastUpdate.rawValue)
        }
    }
    
    var reservationOptionsData: Data? {
        get {
            UserDefaults.standard.data(forKey: keys.reservationData.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: keys.reservationData.rawValue)
        }
    }
}
