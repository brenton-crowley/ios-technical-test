//
//  Double+Extensions.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation


extension Double {
    
    /// Helper function that mutates a double value and rounds it to the nearest tenth.
    /// - Returns: A double rounded to the nearest tenth.
    func roundedToNearestTenth() -> Double {
        let roundedValue = (self * 10).rounded() / 10
        return roundedValue
    }
}
