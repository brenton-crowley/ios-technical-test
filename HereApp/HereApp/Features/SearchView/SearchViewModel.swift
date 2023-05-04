//
//  SearchViewModel.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation
import MapKit
import CoreLocation

class SearchViewModel: NSObject, ObservableObject, APIManageable, CLLocationManagerDelegate {
    
    struct Constants {
        static let melbourneLocation = CLLocation(latitude: -37.840935, longitude: 144.946457)
    }
    
    @Published private(set) var stations: [Station] = []
    @Published private(set) var authorisationState = CLAuthorizationStatus.notDetermined
    @Published private(set) var hasFetchedStations = false
    @Published private(set) var observation:Observation?
    @Published private(set) var departures:[Departure]?
    
    private(set) var locationManager = CLLocationManager()
    
    @MainActor
    override init() {
        super.init()
        
        // set up location manager
        locationManager.delegate = self
        
        // make a call to fetch something
        
        // load api key from plist
        if let plist = Bundle.loadAPIKeyPlistName(APIConstants.apiKeyPlistFilename),
           let apiKey = plist.first {
            APIConstants.apiKey = apiKey
            fetchStations()
        } else {
            self.stations = [ Station.stationAsNoApiKeySuppliedMessage ]
        }
    }
    
    // MARK: - Onboarding Intents
    
    func requestGeolocationPermission() {
        // Request location persmission
        // Update `Privacy - Location When In Use Usage Description` flag in info.plist with string for request
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - APIManageable related calls
    
    @MainActor
    private func fetchStations(fromLocation location: CLLocation = SearchViewModel.Constants.melbourneLocation) {
        let request = GetStationsNearMeRequest(location)
        Task {
            do {
                guard let data = try await self.performRequest(request, expectedResponseCode: 200, printResponse: true) else { return }
                guard let response =  try self.parseJSONData(data, type: RootStationResponse.self) else { return }
                
                self.stations = response.stations
                
            } catch {
                print(error)
            }
            
        }
    }
    
    @MainActor
    func fetchWeatherForStation(_ station:Station) {
        let location = CLLocation(latitude: station.place.location.lat, longitude: station.place.location.lng)
        let request = GetWeatherObservationRequest(location)
        Task {
            do {
                guard let data = try await self.performRequest(request, expectedResponseCode: 200, printResponse: true) else { return }
                
                guard let response =  try self.parseJSONData(data, type: RootWeatherResponse.self) else { return }
                
//                dump(response)
                
                self.observation = response.places.first?.observations.first
                
            } catch {
                print(error)
            }
            
        }
    }
    
    @MainActor
    func fetchDeparturesForStation(_ station:Station) {
        
        let request = GetDeparturesForStationRequest(station.id)
        
        Task {
            do {
                guard let data = try await self.performRequest(request, expectedResponseCode: 200, printResponse: true) else { return }
                guard let response =  try self.parseJSONData(data, type: RootDepartureResponse.self) else { return }
                
                dump(response)
                
                self.departures = response.boards.first?.departures
                
            } catch {
                print(error)
            }
            
        }
    }
    
    // MARK: - Location Manager Delegate Methods
    /// Delegate method that is called when the user changes the location authorisation value.
    /// - Parameter manager: the locationManager on which the setting was changed.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        self.authorisationState = locationManager.authorizationStatus
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            // we don't have permission.
            break
        }
    }
    
    /// Delegate methods that's called when the user's location is updated.
    /// - Parameters:
    ///   - manager: the locationManager on which the locations were found.
    ///   - locations: array of user's locations.
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        
        if let location = locations.first {
            
            locationManager.stopUpdatingLocation()

            if !hasFetchedStations {
                fetchStations(fromLocation: location)
                hasFetchedStations = true
            }
        }
        
        
        // Stop updating the location after we get it if we only need it once.
        print(locations.first ?? "no location")
    }
    
    // MARK: - StationsMapView methods
    
    /// Map self.stations to an MKPointAnnotation
    /// - Returns: Array of [MKPointAnnotation] mapped from self.stations
    public func getStationsAsAnnotations() -> [MKPointAnnotation] {
        
        let annotations:[MKPointAnnotation] = self.stations.map { station in
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
        
        return self.stations.first { station in
            
            let sameLatitude = (station.place.location.lat == coordinate.latitude)
            let sameLongitude = (station.place.location.lng == coordinate.longitude)
            
            return sameLatitude && sameLongitude
        }
    }
}
