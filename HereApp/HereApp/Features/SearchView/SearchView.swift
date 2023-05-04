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
            StationsMapView(selectedStation: $selectedStation)
                .ignoresSafeArea()
                .toolbar(.hidden)
                .sheet(item: $selectedStation) { station in
                    // create a station detail view instance.
                    // TODO: Make a station detail view with required information. This will likely be an Objective-C view
                    Text("Station Name: \(station.place.name)")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
