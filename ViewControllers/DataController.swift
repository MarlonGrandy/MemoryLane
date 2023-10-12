//  StreakController.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/1/22.
//
//  This file defines the data controller methods for handling CRUD operations on the DataModel using CoreData.

import Foundation
import CoreData
import UIKit

/// DataController class provides an interface for interacting with the app's persistent data store.
class DataController: ObservableObject {
    
    // Persistent container for CoreData data model.
    let container = NSPersistentContainer(name: "DataModel")
    
    /// Initializes the DataController and loads the persistent store.
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to Load the Data \(error.localizedDescription)")
            }
        }
    }
    
    /// Saves changes to the provided context.
    ///
    /// - Parameter context: The managed object context to save.
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved!!")
        } catch {
            print("Data not saved :(")
        }
    }
    
    /// Creates a new memory entry in the database.
    ///
    /// - Parameters:
    ///   - memories: The memory description or note.
    ///   - prompt: The associated prompt for the memory.
    ///   - is_daily: Flag to indicate if it's a daily memory or not.
    ///   - img: Image data associated with the memory.
    ///   - context: The managed object context in which the new entry should be created.
    func newMemory(memories: String, prompt: String, is_daily:Bool, img: Data, context: NSManagedObjectContext) {
        let data = DailyPrompt(context: context)
        data.id = UUID()
        data.memory = memories
        data.date = Date()
        data.prompt = prompt
        data.is_daily = is_daily
        data.img = img
        
        save(context: context)
    }
}

// Extension to provide Identifiable conformance for the DataController.
extension DataController: Identifiable {
}
