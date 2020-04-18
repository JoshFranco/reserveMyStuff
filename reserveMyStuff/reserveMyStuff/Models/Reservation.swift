//
//  Reservation.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

struct Reservation: Codable {
    let date: Date
    let name: String
    let size: Int
    let duration: TimeInterval
    let description: String
    
    public enum CodingKeys: String, CodingKey {
        case date = "reservation_date"
        case name = "reservation_name"
        case size = "reservation_size"
        case duration = "reservation_duration"
        case description = "reservation_description"
    }
}
