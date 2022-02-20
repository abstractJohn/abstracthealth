//
//  ContentView.swift
//  AHWatchApp WatchKit Extension
//
//  Created by John Nelson on 2/18/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Medication.name, ascending: true)],
        animation: .default) private var medications: FetchedResults<Medication>
    @State private var selectedMedication: Medication
    
    init(moc: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Medication> = Medication.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Medication.name, ascending: true)]
                fetchRequest.predicate = NSPredicate(value: true)
                self._medications = FetchRequest(fetchRequest: fetchRequest)
                do {
                    let firstMed = try moc.fetch(fetchRequest)
                    self._selectedMedication = State(initialValue: firstMed[0])
                } catch {
                    fatalError("Uh, fetch problem...")
                }
    }
    var body: some View {
        VStack {
            Picker("Medications",selection: $selectedMedication, content: {
                ForEach(medications) {
                    medication in
                    Text(medication.name ?? "")
                }
            })
                .padding()
                .pickerStyle(.automatic)
            Button {
                addIncident()
            } label: {
                Text("Used")
            }
        }
    }
    
    private func addIncident() {
        withAnimation {
            let newIncident = Incident(context: viewContext)
            newIncident.time = Date()
            newIncident.addToMedications(selectedMedication)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(moc: PersistenceController.preview.container.viewContext)
    }
}
