//
//  ReservationOption.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

struct ReservationOption: Codable {
    let title: String
    let price: Int
    let description: String
    let durationOptions: [TimeInterval]
    
    public enum CodingKeys: String, CodingKey {
        case title = "reservation_option_title"
        case price = "reservation_option_price"
        case description = "reservation_option_description"
        case durationOptions = "reservation_option_duration_options"
    }
}
