//
//  DepartureResponse.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

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
