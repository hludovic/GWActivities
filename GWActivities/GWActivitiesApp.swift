//
//  GWActivitiesApp.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 05/06/2023.
//

import SwiftUI

@main
struct GWActivitiesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
