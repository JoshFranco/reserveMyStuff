//
//  ReservationOptions.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

struct ReservationOptions: Codable {
    let options: [ReservationOption]
    
    public enum CodingKeys: String, CodingKey {
        case options = "reservation_options"
    }
}
