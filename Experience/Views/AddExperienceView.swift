//
//  AddExperienceView.swift
//  Experience
//
//  Created by Nelson Gonzalez on 3/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import MapKit

struct AddExperienceView: View {
    @ObservedObject var experienceController: ExperienceController
    @ObservedObject var locationManager: LocationManager
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var showAlert = false
    @State private var isEmptyFieldError = false
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    var body: some View {
        VStack {
            TextField("Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle()).frame(height: 50)
            Button(action: {
                if self.title != "" {
                   // guard let coordinate = self.locationManager.location?.coordinate else { return }
                    self.experienceController.createExperienceWith(title: self.title, coordinate: self.centerCoordinate)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showAlert = true
                    self.isEmptyFieldError = true
                }
            }) {
                Text("Add Experience").foregroundColor(.white).bold().frame(width: UIScreen.main.bounds.width - 30, height: 50)
            }.background(Color.blue).alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(isEmptyFieldError ? "Title can not be empty" : "There was an error please try again"), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }.padding()
    }
}

struct AddExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        AddExperienceView(experienceController: ExperienceController(), locationManager: LocationManager(), centerCoordinate: .constant(CLLocationCoordinate2D(latitude: 94.5, longitude: 98.9)))
    }
}
