//
//  MemoryLaneApp.swift
//  Shared
//  Created by Marlon Grandy on 8/30/22.
//  This file defines the main app entry point for MemoryLane.

import SwiftUI

@available(iOS 16.0, *)
@main
struct MemoryLaneApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        // A scene representing the main window of the app.
        WindowGroup {
            ContentView()
            // Provides the content view with the managed object context from the data controller.
            // This allows the content view to interact with and use the data.
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
