//
//  GetWeatherObservationRequest.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation
import CoreLocation

struct GetWeatherObservationRequest: Requestable {
    
    // Endpoint
    // https://weather.hereapi.com/v3/report?products=observation&location=-37.840935,144.946457
    
    var host: String = "weather.hereapi.com"
    var version: String = "/v3"
    var path: String = "/report"
    var queryParams: [String : String?] = [:]
    
    
    init(_ location:CLLocation = SearchViewModel.Constants.melbourneLocation) {
        queryParams["products"] = "observation"
        queryParams["location"] = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        queryParams["oneObservation"] = "true"
    }
    
}
