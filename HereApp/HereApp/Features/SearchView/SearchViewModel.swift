//
//  SearchViewModel.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

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
    
}
