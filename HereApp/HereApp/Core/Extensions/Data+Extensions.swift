//
//  Data+Extensions.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

/// Not my extension. Sourced from: https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
