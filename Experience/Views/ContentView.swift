//
//  ContentView.swift
//  Experience
//
//  Created by Nelson Gonzalez on 3/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var experienceController = ExperienceController()
    @State private var showingAddScreen = false
    @State private var centerCoordinate = CLLocationCoordinate2D() //Needed to pass in coordinates for location
    
    var body: some View {
        
            ZStack {
                
                MapView(experienceController: experienceController, centerCoordinate: $centerCoordinate).edgesIgnoringSafeArea(.all)
                Circle().fill(Color.blue).opacity(0.3).frame(width: 32, height: 32)
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            
                            self.showingAddScreen = true
                        }) {
                            Image(systemName: "plus")
                        }.padding().background(Color.black.opacity(0.75)).foregroundColor(.white).font(.title).clipShape(Circle()).padding(.trailing)
                    }
                }
            }.sheet(isPresented: $showingAddScreen) {
                
                AddExperienceView(experienceController: self.experienceController, locationManager: self.locationManager, centerCoordinate: self.$centerCoordinate)
                
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
