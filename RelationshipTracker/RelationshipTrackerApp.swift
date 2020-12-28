//
//  RelationshipTrackerApp.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/28/20.
//

import SwiftUI

@main
struct RelationshipTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
