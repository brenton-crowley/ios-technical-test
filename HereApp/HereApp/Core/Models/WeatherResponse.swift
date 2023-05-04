//
//  WeatherResponse.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

// Reflects JSON object from this endpoint: // https://weather.hereapi.com/v3/report?products=observation&location=-37.840935,144.946457
struct RootWeatherResponse:Decodable {
    
    let places: [WeatherPlace]
    
}

struct WeatherPlace: Decodable {
    
    let observations: [Observation]
    
}

struct Observation: Decodable {
    
    let description, iconName, iconLink: String
    let temperature: Double
    
}
