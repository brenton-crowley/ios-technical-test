//
//  ContentView.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject private var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.stations) { station in
                Text(station.place.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
