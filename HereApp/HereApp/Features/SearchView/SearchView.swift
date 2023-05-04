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
        ZStack {
            
            switch viewModel.authorisationState {
                
            case .authorizedAlways, .authorizedWhenInUse:
                // if approved, show home view
                if viewModel.hasFetchedStations {
                    mapView
                } else {
                    ProgressView()
                }
            case .notDetermined:
                // if undertermined show onboarding
                onboardingView
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
                // create a station detail view instance.
                // TODO: Make a station detail view with required information. This will likely be an Objective-C view
                Text("Station Name: \(station.place.name)")
            }
    }
    
    var onboardingView: some View {
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
    }
}
