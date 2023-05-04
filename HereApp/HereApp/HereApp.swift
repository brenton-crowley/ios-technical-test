//
//  HereAppApp.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import SwiftUI

@main
struct HereApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(SearchViewModel())
        }
    }
}