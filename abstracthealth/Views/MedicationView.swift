//
//  MedicationView.swift
//  abstracthealth
//
//  Created by John Nelson on 2/19/22.
//

import SwiftUI
import CoreData

struct MedicationView: View {
    let medication: Medication
    @State private var isPresentingEditView = false
    var body: some View {
        List {
            Section(header: Text("Medication Info")) {
                
                Text("Last Used: \(medication.lastUsed)")
                    .font(.headline)
                Text("Last Filled \(medication.lastFilledString)")
                    .font(.headline)
                Text("Refills Remaining: \(medication.refillsString)")
                Text("Prescribed by: \(medication.wrappedPrescriber)")
                Text("Started On: \(medication.startedString)")
            }
            Section(header: Text("Times Taken")) {
                ForEach(medication.incidentsArray) {
                    incident in
                    Text(incident.viewName)
                }
            }
           
        }
        .navigationTitle(Text(medication.wrappedName))
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                MedicationEditView()
                    .navigationTitle(medication.wrappedName)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}

struct MedicationView_Previews: PreviewProvider {
    static var medication: Medication = Medication(context: PersistenceController.preview.container.viewContext)
    static var previews: some View {
        MedicationView(medication: medication)
    }
}
