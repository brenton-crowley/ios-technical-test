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
        static let nibName = "StationDetailView"
        static let hideAlpha:CGFloat = 0
        static let showAlpha:CGFloat = 1
        static let animationDuration = 0.5
    }
    
    // Add any properties you need to pass to the Objective-C view here
//    var departures:[Departure]?
    @EnvironmentObject private var viewModel:SearchViewModel
    
    let station: Station
    
    
    func makeUIView(context: Context) -> UIView {
        // Load the Objective-C view from the nib
        
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! StationDetailView
        
        view.departuresTableView?.register(UITableViewCell.self, forCellReuseIdentifier: Constants.dequeueIdentifier)
        view.parent = context.coordinator
        view.iconView?.alpha = Constants.hideAlpha
        view.temperatureLabel?.alpha = Constants.hideAlpha
        view.descLabel?.alpha = Constants.hideAlpha
        
        view.temperatureLabel?.text = ""
        view.descLabel?.text = ""
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
        let view:StationDetailView? = (uiView as? StationDetailView)
        
        let temperature = viewModel.observation?.temperature != nil ? "\(viewModel.observation!.temperature.roundedToNearestTenth())ºC" : ""
        
        view?.departuresTableView?.reloadData()
        view?.iconView?.image = viewModel.weatherImage
        view?.stationNameLabel?.text = station.place.name
        view?.temperatureLabel?.text = temperature
        view?.descLabel?.text = viewModel.observation?.description
        
        if let view = view {
            fadeInViews(view)
        }
    }

    private func fadeInViews(_ view: StationDetailView) {
        
        // Set initial alpha to 0
        view.iconView?.alpha = Constants.hideAlpha
        view.temperatureLabel?.alpha = Constants.hideAlpha
        view.descLabel?.alpha = Constants.hideAlpha

        // Add the image view to your view hierarchy

        UIView.animate(withDuration: Constants.animationDuration) {
            // Set the final alpha to 1 inside the animation block
            view.iconView?.alpha = Constants.showAlpha
            view.temperatureLabel?.alpha = Constants.showAlpha
            view.descLabel?.alpha = Constants.showAlpha
        }
        
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
    }
    
}
