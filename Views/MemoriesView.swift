//
//  MemoriesView.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/3/22.
//
//  This file defines the view responsible for displaying a collection of
//  previously saved memory prompts. It integrates with the EachMemory view
//  for individual memory presentations and provides navigation controls via
//  the ControlBarView. The design and background aesthetics are also
//  customizable based on user preferences.

import SwiftUI
import RandomColor

struct MemoriesView: View {
    
    // Context for interacting with Core Data.
    @Environment(\.managedObjectContext) var managedObjContext
    
    // Fetch request for retrieving saved daily prompts, sorted in reverse chronological order.
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var mem: FetchedResults<DailyPrompt>
    
    // Binding to control the current view displayed on the screen.
    @Binding var viewPicker: Int
    
    // App storage variable for retrieving the user's preferred background color.
    @AppStorage("color pick") var colorPicked = "starry sky"
    
    var body: some View {
        VStack {
            // App title and design aesthetics.
            Text("Memory Ln.")
                .font(.system(size: 40, weight: .bold, design: .serif))
                .padding(.top, 10)
                .foregroundColor(Color.white)
            
            // Invokes the EachMemory view for presenting individual memories.
            EachMemory()
            
            // Control bar for navigation and view selection.
            ControlBarView(viewPicker: $viewPicker)
        }
        .fullBackground(imageName: colorPicked)
    }
}

// Preview provider for the SwiftUI canvas.
struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView(viewPicker: .constant(2))
    }
}
