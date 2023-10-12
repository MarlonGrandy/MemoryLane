//
//  pastmemory.swift
//  MemoryLane
//  Created by Marlon Grandy on 10/8/22.
//
//  This file creates a view to display the detailed contents of a memory.
//  It is invoked after a user selects a prompt from the `MemoriesView`.

import SwiftUI

struct PastMemory: View {
    // State properties to store details of the memory.
    @State var mem_text: String      // Text content of the memory.
    @State var date_text: Date       // Date when the memory was recorded.
    @State var prompt_text: String   // Prompt associated with the memory.
    @State var img: Data?            // Optional image associated with the memory.
    
    var body: some View {
        ZStack {
            // Setting a black background that ignores safe areas.
            Color.black
                .ignoresSafeArea()
            
            VStack {
                // Display the date of the memory.
                Text("Date: \(toDate(date: date_text))")
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 10)
                
                // Display the associated prompt.
                Text("\(prompt_text)")
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .foregroundColor(Color.white)
                
                // Divider to separate the prompt from the memory content.
                Divider()
                    .foregroundColor(Color.white)
                    .overlay(Color.white)
                
                // Display the memory text content.
                Text("\(mem_text)")
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .foregroundColor(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                
                Spacer()
                
                // Check if an image is associated with the memory and display it.
                if let dataTest = img, let imgTest = UIImage(data: img!) {
                    Text("Your Memory Was Connected To This Photo...")
                        .font(.system(size: 16, weight: .regular, design: .serif))
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    
                    Image(uiImage: imgTest)
                        .resizable()
                }
            }
            
            Spacer()
            Spacer()
            Spacer()
        }
    }
    
    // Function to convert Date to a short string format.
    private func toDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
