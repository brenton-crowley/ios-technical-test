//
//  ContentView.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject private var viewModel: SearchViewModel
    
    @State private var selectedStation:Station?
    
    var body: some View {
        viewForAuthorisationState
    }
    
    var viewForAuthorisationState: some View {
        Group {
            switch viewModel.authorisationState {
                
            case .authorizedAlways, .authorizedWhenInUse:
                // if approved, show home view
                if viewModel.hasFetchedStations {
                    mapView
                        .onChange(of: selectedStation) { _ in
                            if let selectedStation = selectedStation {
                                // request weather details
                                viewModel.fetchWeatherForStation(selectedStation)
                                viewModel.fetchDeparturesForStation(selectedStation)
                            }
                        }
                } else {
                    ProgressView() // making API call
                }
            case .notDetermined:
                // if undertermined show permission request view
                requestPermissionView
            case .denied:
                // if denied, show go to settings view
                LocationDeniedView()
            default:
                EmptyView()
            }
        }
    }
    
    var mapView: some View {
        StationsMapView(selectedStation: $selectedStation)
            .ignoresSafeArea()
            .toolbar(.hidden)
            .sheet(item: $selectedStation) { station in
                StationDetailViewWrapper(station: station)
            }
    }
    
    var requestPermissionView: some View {
        Button {
            viewModel.requestGeolocationPermission()
        } label: {
            Label("Authorise Location", systemImage: "location.circle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchViewModel())
    }
}
