//
//  Double+Extensions.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

extension Double {
    func roundedToNearestTenth() -> Double {
        let roundedValue = (self * 10).rounded() / 10
        return roundedValue
    }
}
