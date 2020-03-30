//
//  Experience.swift
//  BucketList
//
//  Created by Nelson Gonzalez on 3/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import MapKit

class Experience: NSObject, MKAnnotation {

    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
  //  var image: UIImage
    var id = UUID()
    
    init(title: String,/* image: UIImage,*/ subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
       // self.image = image
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
