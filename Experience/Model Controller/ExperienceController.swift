//
//  ExperienceController.swift
//  BucketList
//
//  Created by Nelson Gonzalez on 3/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ExperienceController: ObservableObject {
    
    @Published private(set) var experiences: [Experience] = []
    
    func createExperienceWith(title: String, /*image: UIImage,*/ subtitle: String = "Description here...", coordinate: CLLocationCoordinate2D) {
        let experience = Experience(title: title, /*image: image,*/  subtitle: subtitle, coordinate: coordinate)
        saveExperience(experience)
    }
    
    func saveExperience(_ experience: Experience) {
        self.experiences.append(experience)
    }
}
