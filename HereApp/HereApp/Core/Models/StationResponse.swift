//
//  StationResponse.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

struct RootResponse: Decodable {
    let stations: [Station]
}

struct Station: Decodable, Identifiable {
    
    let place: Place
    var id: String { place.id }
}

struct Place:Decodable {
    let name, type, id: String
    let location:Location
}

struct Location:Decodable {
    let lat, lng: Double
}

extension Station {
    
    static var stationAsNoApiKeySuppliedMessage:Station {
        Station(place:
                    Place(name: "No API Key Provided", type: "", id: "1", location: Location(lat: 0.0, lng: 0.0))
               )
    }
    
}
