//
//  GetDeparturesForStationRequest.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

import CoreLocation

struct GetDeparturesForStationRequest: Requestable {
    
    // Endpoint
    // https://transit.hereapi.com/v8/departures?ids=401901619
    
    var path: String = "/departures"
    var queryParams: [String : String?] = [:]
    
    
    init(_ id: String) {
        queryParams["ids"] = "\(id)"
    }
    
}
