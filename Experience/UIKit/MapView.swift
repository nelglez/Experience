//
//  MapView.swift
//  BucketList
//
//  Created by Nelson Gonzalez on 12/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var experienceController: ExperienceController
    @Binding var centerCoordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
       
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        print("Updating")
      
            view.removeAnnotations(view.annotations)
            let experiences = Set(experienceController.experiences)
            
            let currentAnnotations = Set(view.annotations.compactMap({ $0 as? Experience }))
            
            let addedExperiences = Array(experiences.subtracting(currentAnnotations))
            
            
            view.addAnnotations(addedExperiences)
      
    }
  
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"

            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
              //  let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
                               
              //  leftIconView.image = UIImage(named: "eleven")
            
                               
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
               // annotationView?.leftCalloutAccessoryView = leftIconView
               // annotationView?.detailCalloutAccessoryView = leftIconView
              
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
            
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placeMark = view.annotation as? MKPointAnnotation else { return }
         //   parent.selectedPlace = placeMark
         //   parent.showingPlaceDetails = true
            
        }
        
        
    }
 
}
