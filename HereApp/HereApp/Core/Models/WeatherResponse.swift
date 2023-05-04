//
//  WeatherResponse.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

//{
//    "places": [
//        {
//            "observations": [
//                {
//                    "place": {
//                        "address": {
//                            "countryCode": "AUS",
//                            "countryName": "Australia",
//                            "state": "Victoria",
//                            "city": "Port Melbourne"
//                        },
//                        "location": {
//                            "lat": -37.83961,
//                            "lng": 144.94228
//                        },
//                        "distance": 0.4
//                    },
//                    "daylight": "day",
//                    "description": "Partly sunny. Refreshingly cool.",
//                    "skyInfo": 14,
//                    "skyDesc": "Partly sunny",
//                    "temperature": 15,
//                    "temperatureDesc": "Refreshingly cool",
//                    "comfort": "15.00",
//                    "highTemperature": "16.00",
//                    "lowTemperature": "10.20",
//                    "humidity": "59",
//                    "dewPoint": 7,
//                    "precipitationProbability": 1,
//                    "windSpeed": 0,
//                    "windDirection": 0,
//                    "windDesc": "North",
//                    "windDescShort": "N",
//                    "uvIndex": 0,
//                    "uvDesc": "Minimal",
//                    "barometerPressure": 1019.98,
//                    "barometerTrend": "Falling",
//                    "iconId": 6,
//                    "iconName": "mostly_cloudy",
//                    "iconLink": "https://weather.hereapi.com/static/weather/icon/17.png",
//                    "ageMinutes": 21,
//                    "activeAlerts": 0,
//                    "time": "2023-05-04T14:00:00+10:00"
//                }
//            ]
//        }
//    ]
//}

struct RootWeatherResponse:Decodable {
    
    let places: [WeatherPlace]
    
}

struct WeatherPlace: Decodable {
    
    let observations: [Observation]
    
}

struct Observation: Decodable {
    
    let description, iconName, iconLink: String
    let temperature: Int
    
}
