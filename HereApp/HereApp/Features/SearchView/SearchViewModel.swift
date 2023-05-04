//
//  SearchViewModel.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation
import MapKit
import CoreLocation

class SearchViewModel: ObservableObject, APIManageable {
    
    @Published private(set) var stations: [Station] = []
    
    @MainActor
    init() {
        // make a call to fetch something
        
        // load api key from plist
        if let plist = Bundle.loadAPIKeyPlistName(APIConstants.apiKeyPlistFilename),
           let apiKey = plist.first {
            APIConstants.apiKey = apiKey
            getStations()
        } else {
            self.stations = [ Station.stationAsNoApiKeySuppliedMessage ]
        }
    }
    
    @MainActor
    private func getStations() {
        let request = GetStationsNearMeRequest()
        Task {
            do {
                guard let data = try await self.performRequest(request, expectedResponseCode: 200, printResponse: true) else { return }
                guard let response =  try self.parseJSONData(data, type: RootResponse.self) else { return }
                
                self.stations = response.stations
                
            } catch {
                print(error)
            }
            
        }
    }
    
    // MARK: - StationsMapView methods
    
    /// Map self.stations to an MKPointAnnotation
    /// - Returns: Array of [MKPointAnnotation] mapped from self.stations
    public func getStationsAsAnnotations() -> [MKPointAnnotation] {
        
        var annotations:[MKPointAnnotation] = self.stations.map { station in
            let latitude = station.place.location.lat
            let longitude = station.place.location.lng
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                           longitude:longitude)
            annotation.title = station.place.name
            
            return annotation
        }
        
        return annotations
    }
    
    /// Search for a station that matches the passed in coordinates.
    /// - Parameter coordinate: The coordinates of the business that was tapped.
    /// - Returns: A Station if coordinates match, otherwise nil
    public func getStationForCoordinate(_ coordinate:CLLocationCoordinate2D) -> Station? {
        
        return (self.stations).first { station in
            
            let sameLatitude = (station.place.location.lat == coordinate.latitude)
            let sameLongitude = (station.place.location.lng == coordinate.longitude)
            
            return sameLatitude && sameLongitude
        }
    }
}
