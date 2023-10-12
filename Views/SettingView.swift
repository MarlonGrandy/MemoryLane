//
//  SettingView.swift
//  MemoryLane
//
//  Created by Marlon Grandy on 10/8/22.
//  This file creates a view for the app's settings page. Users can interact with various configuration options presented in the SelectionView and navigate using the ControlBarView.

import SwiftUI

// SettingView defines the UI and behavior for the application's settings page.
struct SettingView: View {
    
    // A binding to a viewPicker property, allowing for view switching.
    @Binding var viewPicker: Int
    
    var body: some View {
        ZStack {
            // The main vertical stack for content.
            VStack {
                // Embedded SelectionView where user can interact with various configuration options.
                SelectionView()
                
                // Integrates the ControlBarView for navigation within the app.
                ControlBarView(viewPicker: $viewPicker)
            }
        }.background(Color.black) // Sets the background color of the entire view to black.
    }
}

// Preview setup for design and layout purposes.
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewPicker: .constant(4))
    }
}
