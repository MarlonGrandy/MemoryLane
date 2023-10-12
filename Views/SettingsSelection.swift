//
//  ColorSelection.swift
//  MemoryLane 2
//
//  Created by Marlon Grandy on 11/4/22.
//  This file creates a view for selecting background color and prompt time period preferences.

import SwiftUI

// `SelectionView` provides UI for users to select their preferences regarding background color and prompt time period.
struct SelectionView: View {
    
    // An array containing available background colors.
    let colors = ["black", "starry sky"]
    @AppStorage("color pick") var colorPicked = "starry sky"
    
    // An array containing available prompt time periods.
    let period = ["childhood", "teenager", "early adulthood", "middle adulthood", "late adulthood"]
    @AppStorage("keyValue") var dictKey = "childhood"
    
    var body: some View {
        if #available(iOS 16.0, *) {
            List {
                // Section for background color selection.
                Section {
                    ForEach(colors, id: \.self) { item in
                        ColorSelectionCell(color: item)
                    }
                } header: {
                    Text("Background Color")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .foregroundColor(Color.white)
                }
                
                // Section for time period selection.
                Section {
                    ForEach(period, id: \.self) { item in
                        TimeSelectionCell(period: item)
                    }
                } header: {
                    Text("Prompt Time Period")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .foregroundColor(Color.white)
                }
            }.scrollContentBackground(.hidden)
        }
    }
}

// A single cell view for selecting background color.
struct ColorSelectionCell: View {
    
    let color: String
    @AppStorage("color pick") var colorPicked = "starry sky"
    
    var body: some View {
        HStack {
            Text(color)
                .foregroundColor(Color.black)
                .font(.system(size: 24, weight: .regular, design: .serif))
            Spacer()
            if color == colorPicked {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }   .onTapGesture {
            self.colorPicked = self.color
        }
    }
}

// A single cell view for selecting prompt time period.
struct TimeSelectionCell: View {
    
    let period: String
    @AppStorage("keyValue") var dictKey = "childhood"
    
    var body: some View {
        HStack {
            Text(period)
                .foregroundColor(Color.black)
                .font(.system(size: 24, weight: .regular, design: .serif))
            Spacer()
            if period == dictKey {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }   .onTapGesture {
            self.dictKey = self.period
        }
    }
}
