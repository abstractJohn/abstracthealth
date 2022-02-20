//
//  abstracthealthApp.swift
//  AHWatchApp WatchKit Extension
//
//  Created by John Nelson on 2/18/22.
//

import SwiftUI
import CoreData

@main
struct abstracthealthApp: App {
    let moc: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(moc: moc)
                    .environment(\.managedObjectContext, moc)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
