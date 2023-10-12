//  ControlBarView.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/12/22.
//  This file creates a control bar view which acts as a navigation tool for the main views of the app.

import SwiftUI

// A View struct to create a horizontally aligned control bar for navigation.
struct ControlBarView: View {
    
    @Binding var viewPicker: Int
    
    var body: some View {
        HStack {
            
            Spacer()
            
            // Button to navigate to the settings view (represented by the gear icon).
            Button{
                viewPicker = 4
            }label:{
                Image(systemName: "gearshape")
                    .font(.system(size: 35, weight: .regular, design: .serif))
                    .imageScale(.large)
                    .font(Font.system(.largeTitle, design: .default))
                    .foregroundColor(Color.white)
            }
            
            Spacer()
            
            // Button to navigate to the clock view (represented by the clock icon).
            Button{
                viewPicker = 1
            } label:{
                Image(systemName: "clock")
                    .imageScale(.large)
                    .font(.system(size: 35, weight: .regular, design: .serif))
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
            }
            
            Spacer()
            
            // Button to navigate to the edit or creation view (represented by the pencil inside square icon).
            Button{
                viewPicker = 3
            } label:{
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
                    .font(.system(size: 35, weight: .regular, design: .serif))
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
            }
            
            Spacer()
            
            // Button to navigate to the list view (represented by the bullet list icon).
            Button{
                viewPicker = 2
            } label:{
                Image(systemName: "list.bullet")
                    .imageScale(.large)
                    .font(.system(size: 35, weight: .regular, design: .serif))
                    .foregroundColor(Color.white)
            }
            
            Spacer()
            
        }
    }
}
