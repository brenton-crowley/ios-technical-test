//
//  StationDetailViewRepresentable.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation
import UIKit
import SwiftUI

struct StationDetailViewWrapper: UIViewRepresentable {

    struct Constants {
        static let dequeueIdentifier = "Cell"
    }
    
    // Add any properties you need to pass to the Objective-C view here
//    var departures:[Departure]?
    @EnvironmentObject private var viewModel:SearchViewModel
    
    func makeUIView(context: Context) -> UIView {
        // Load the Objective-C view from the nib
        
        let nib = UINib(nibName: "StationDetailView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! StationDetailView
        
        view.departuresTableView?.register(UITableViewCell.self, forCellReuseIdentifier: Constants.dequeueIdentifier)
        view.parent = context.coordinator
        // Set up the view with any necessary properties
        // view.property = self.property
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view with any changes that need to be made
        // uiView.property = self.property
        (uiView as? StationDetailView)?.departuresTableView?.reloadData()
    }

    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
        
        let parent:StationDetailViewWrapper
        
        init(parent:StationDetailViewWrapper) {
            self.parent = parent
        }
        
        // MARK: - UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return parent.viewModel.departures?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: StationDetailViewWrapper.Constants.dequeueIdentifier, for: indexPath) as UITableViewCell
                
            if let departure = parent.viewModel.departures?[indexPath.row] {
                cell.textLabel?.text = departure.time.prettyStringDate()
            }
                
            return cell
        }
        
        // MARK: - UITableViewDelegate
        
        
        
    }
    
}
