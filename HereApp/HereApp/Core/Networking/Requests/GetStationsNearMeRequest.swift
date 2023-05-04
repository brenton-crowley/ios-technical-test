//
//  GetStationsNearMeRequest.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation
import CoreLocation

struct GetStationsNearMeRequest:Requestable {
    
    var path: String = "/stations"
    var queryParams: [String : String?] = [:]
    
    init(
        location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -37.840935, longitude: 144.946457),
        radiusInMeters: Int = 500) {
        self.queryParams["in"] = "\(location.latitude),\(location.longitude)"
        self.queryParams["r"] = "\(radiusInMeters)"
    }
    
}
