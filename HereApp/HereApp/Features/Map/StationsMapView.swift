//
//  MapView.swift
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

import Foundation

import SwiftUI
import MapKit

/// Adds a MKMapView to the UI.
struct StationsMapView: UIViewRepresentable {
    
    struct Constants {
        
        static let annotationIdentifier:String = "stationAnnotation"
        static let regionDegreeDelta = 0.01
        
    }
    
    @Binding var selectedStation:Station?

    @EnvironmentObject private var model:SearchViewModel
    /// Create the map view to display the business on.
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        mapView.delegate = context.coordinator // let the system handle the assignment of the delegate.
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading // as the user moves, so too does the map.
        
        return mapView
        
    }
    
    /// Called when the user interface needs to redraw itself.
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // remove any existing annotations so we don't overlap.
        uiView.removeAnnotations(uiView.annotations)
        uiView.showAnnotations(model.getStationsAsAnnotations(), animated: false) // display the animations.
        
        // zoom the camera
        uiView.setRegion(MKCoordinateRegion(
            center: uiView.userLocation.coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: StationsMapView.Constants.regionDegreeDelta,
                longitudeDelta: StationsMapView.Constants.regionDegreeDelta)),
                         animated: false)
    
    }
    
    /// Destroys the map view.
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(map: self) }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        let stationsMap:StationsMapView
        
        init(map:StationsMapView) {
            self.stationsMap = map
        }
        
        /// Delegate method generates an annotation view to display on the map based on the available stations.
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // If the annotation is the user's blue dot, then we don't want to create an annotation view
            guard !(annotation is MKUserLocation) else { return nil }
            
            // check for resusable annotation view
            if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: StationsMapView.Constants.annotationIdentifier) {
                existingView.annotation = annotation
                return existingView
            } else {
                // create a new annotation view
                let av = MKMarkerAnnotationView(annotation: annotation,
                                                reuseIdentifier: StationsMapView.Constants.annotationIdentifier)
                av.canShowCallout = true
                av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    
                return av
            }
        }
        
        /// Delegate method that sets the selected station when an annotation view's detail disclousure is tapped.
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            if let coordinate = view.annotation?.coordinate,
               let station = stationsMap.model.getStationForCoordinate(coordinate){
                
                stationsMap.selectedStation = station
                print("Station selected: \(station.place.name)")
            }
        }
    }
}
