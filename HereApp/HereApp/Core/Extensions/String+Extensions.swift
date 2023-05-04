//
//  String+Extension.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

extension String {
    
    /// Helper function that converts a formatted server date into a human readable format.
    /// Server string format is: "yyyy-MM-dd'T'HH:mm:ssZ"
    /// - Returns: A human readable string
    func prettyStringDate() -> String {
        
        // Create a date formatter to parse the string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: self) {
            // Create a second date formatter to format the date into a human-readable string
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            
            let displayString = displayFormatter.string(from: date)
            return displayString // "May 4, 2023 at 6:17:00 AM"
        } else {
            print("Invalid date string")
            return self
        }

        
    }
    
}
