//  dateView.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/12/22.
//  This file creates a stylized capsule view designed to display date-based reflection analytics.

import SwiftUI

// A View struct to create a custom capsule-like design to display a title and its associated date value.
struct DateView: View {
    
    // State property to hold the title text of the capsule.
    @State var title: String
    
    // A binding property that represents the date value associated with the title.
    @Binding var titleValues: String
    
    var body: some View {
        ZStack {
            // Base layer: semi-transparent white background with rounded corners.
            Color.white
                .cornerRadius(8)
                .opacity(0.75)
            
            // Middle layer: vertically stacked title and date text.
            VStack{
                Spacer()
                // Display the title text.
                Text(title)
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                Spacer()
                // Display the date value.
                Text(String(titleValues))
                    .font(.system(size: 35, weight: .regular, design: .serif))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        // Outer layer: Add a rounded rectangular border with shadows for the neomorphic look.
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                        lineWidth: 4)
                .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255),
                        radius: 3, x: 5, y: 5)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .shadow(color: Color.white, radius: 2, x: -2, y: -2)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
        )
        // Set the background color and shape properties of the capsule.
        .background(Color(red: 236/255, green: 234/255, blue: 235/255))
        .cornerRadius(10)
        .frame(width:100, height:100)
    }
}
