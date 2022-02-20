//
//  SettingsView.swift
//  Abstract Breathing
//
//  Created by John Nelson on 2/14/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Medication.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Medication.name, ascending: true)], animation: .default)
    private var medications: FetchedResults<Medication>
    @Environment(\.presentationMode) var presentationMode
    @State var name: String = UserDefaults.standard.value(forKey: "User Name") as? String ?? ""
    @State var displayAddSheet: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Name", text: $name)
                        .onSubmit {
                            UserDefaults.standard.setValue(name, forKey: "User Name")
                        }
                        .submitLabel(.done)
                }
                Section(header: HStack {
                    Text("Medications")
                    Spacer()
                    Button {
                        displayAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.body)
                    }
                }) {
                    
                        List {
                            ForEach(medications, id: \.name) { medication in
                                    Text(medication.name ?? "")
                            }
                            .onDelete(perform: deleteMedications)
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .sheet(isPresented: $displayAddSheet, onDismiss: {
            displayAddSheet = false
        }, content:{ AddMedication {
            newName in
            addMedication(name: newName)
            displayAddSheet = false
        }})
        
    }
    private func addMedication(name: String) -> Void {
        withAnimation {
            let newMedication = Medication(context: viewContext)
            newMedication.name = name

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
    
    private func deleteMedications(offsets: IndexSet) {
        withAnimation {
            offsets.map { medications[$0] }.forEach(viewContext.delete)

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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

