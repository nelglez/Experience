//
//  LocationManager.swift
//  BucketList
//
//  Created by Nelson Gonzalez on 3/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    @Published var cityNameStr = ""
    
    override init() {
        
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Authorize.")
               
                let latitude: CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
                let longitude: CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
                let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    if error != nil {
                        return
                    } else if let country = placemarks?.first?.country,
                        let city = placemarks?.first?.locality {
                        print(country)
                        self.cityNameStr = city
                        print("CITY NAME: \(city)")
                         
                        print("country: \(country)")
                      
                    }
                    else {
                    }
                })
                break

            case .notDetermined:
                print("Not determined.")
               locationManager.requestWhenInUseAuthorization()
                break

            case .restricted:
                print("Restricted.")
                
                break

            case .denied:
                print("Denied.")
            @unknown default:
                fatalError()
            }
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
        manager.stopUpdatingLocation()
    }
    
    
    
   
    
}
