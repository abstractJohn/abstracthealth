//
//  abstracthealthApp.swift
//  abstracthealth
//
//  Created by John Nelson on 2/18/22.
//

import SwiftUI

@main
struct abstracthealthApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
