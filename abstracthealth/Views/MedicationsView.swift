//
//  MedicationsView.swift
//  abstracthealth
//
//  Created by John Nelson on 2/19/22.
//

import SwiftUI

struct MedicationsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Medication.name, ascending: false)],
        animation: .default)
    private var medications: FetchedResults<Medication>
    var body: some View {
        NavigationView {
            List {
                ForEach(medications) {
                    medication in
                    NavigationLink {
                        MedicationView(medication: medication)
                    } label: {
                        Text("\(medication.wrappedName) Last Used: \(medication.lastUsed)")
                    }
                }
            }
        }
    }
}

struct MedicationsView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
