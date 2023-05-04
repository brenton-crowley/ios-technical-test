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
        _ location: CLLocation = SearchViewModel.Constants.melbourneLocation,
        radiusInMeters: Int = 500) {
        self.queryParams["in"] = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        self.queryParams["r"] = "\(radiusInMeters)"
    }
    
}
