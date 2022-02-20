//
//  ContentView.swift
//  abstracthealth
//
//  Created by John Nelson on 2/18/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Incident.time, ascending: false)],
        animation: .default)
    private var incidents: FetchedResults<Incident>
    private var userName: String = UserDefaults.standard.value(forKey: "User Name") as? String ?? ""
    @State var settingsOpen: Bool = false
    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(incidents) { incident in
                        NavigationLink {
                            IncidentView( incident: incident)
                        } label: {
                            Text(incident.viewName)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Greetings \(userName)!")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addIncident) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "heart.text.square")
                Text("Incidents")
            }
            MedicationsView()
                .tabItem {
                    Image(systemName: "pills.fill")
                    Text("Medications")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
    
    private func addIncident() {
        //TODO
        // open addIncident screen
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { incidents[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
