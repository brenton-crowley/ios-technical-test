//
//  DepartureResponse.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

// Reflects JSON objects based ont his endpoint: // https://transit.hereapi.com/v8/departures?ids=401901619
struct RootDepartureResponse: Decodable {
    
    let boards: [Boards]
    
}

struct Boards: Decodable {
    
    let place: Place
    let departures: [Departure]
    
}

struct Departure: Decodable, Identifiable {
    
    let time: String
    var id: String { time }
    
}
