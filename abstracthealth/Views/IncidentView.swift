//
//  IncidentView.swift
//  abstracthealth
//
//  Created by John Nelson on 2/19/22.
//

import SwiftUI
import CoreData

struct IncidentView: View {
    var incident: Incident
    
    var body: some View {
        
        List {
            
            Section(header: Text("Medications")) {
                ForEach(incident.medicationsArray) {
                    medication in
                    Text(medication.wrappedName)
                }
            }
            Section(header: Text("Symptoms")) {
                ForEach(incident.syptomsArray) {
                    symptom in
                    Text(symptom.wrappedName)
                }
            }
            Section(header: Text("Triggers")) {
                ForEach(incident.triggersArray) {
                    trigger in
                    Text(trigger.wrappedName)
                }
            }
            
        }
    }
}

struct IncidentView_Previews: PreviewProvider {
    static var previews: some View {
       // IncidentView()
        Text("No Preview")
    }
}
