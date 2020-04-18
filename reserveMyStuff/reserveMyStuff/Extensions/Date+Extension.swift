//
//  Date+Extension.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import Foundation

extension Date {
    func adding(_ component: Calendar.Component, _ value: Int) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: self)
    }
}
