//
//  EachMemory.swift
//  MemoryLane
//  Created by Marlon Grandy on 10/8/22.
//
//  This file creates a view that displays all previous prompts. Tapping on a prompt
//  links to `PastMemory` to view the memory associated with the selected prompt.

import SwiftUI

// The `EachMemory` view displays a list of prompts previously provided to the user.
struct EachMemory: View {
    
    // Access to the current managed object context from Core Data.
    @Environment(\.managedObjectContext) var managedObjContext
    
    // A fetch request to get the daily prompts, sorted by date in descending order.
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    var mem: FetchedResults<DailyPrompt>
    
    // State properties to control the display of a memory's details.
    @State var showing_memory = false
    @State var selectedMem: DailyPrompt? = nil
    
    var body: some View {
        ScrollView() {
            // Iterate through all the memory prompts.
            ForEach(mem, id: \.self) { memory in
                LazyVStack(spacing: 0) {
                    // Button that presents the memory associated with the selected prompt.
                    Button {
                        self.showing_memory = true
                        self.selectedMem = memory
                    } label: {
                        VStack {
                            Text("\(memory.prompt!)")
                                .padding([.leading, .trailing], 10)
                                .font(.system(size: 24, weight: .regular, design: .serif))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(5)
                                .foregroundColor(Color.black)
                                .lineLimit(2)
                        }
                        // Styling for the prompt button.
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.white)
                                .padding(4)
                                .padding(.leading, 3)
                                .padding(.trailing, 3)
                                .opacity(0.75)
                                .frame(height: 100)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .strokeBorder(Color.white, lineWidth: 0)
                                .padding(4)
                                .padding(.leading, 3)
                                .padding(.trailing, 3)
                                .opacity(0.75)
                        )
                        .frame(height: 100)
                    }
                    // Sheet presenting the detailed memory view.
                    .sheet(isPresented: $showing_memory, content: {
                        // Display the full memory details if an image is present.
                        if let memTest = selectedMem?.img! {
                            PastMemory(
                                mem_text: selectedMem!.memory!,
                                date_text: selectedMem!.date!,
                                prompt_text: selectedMem!.prompt!,
                                img: selectedMem!.img!
                            )
                        } else {
                            // Display a placeholder text if no image is present.
                            Text("not presenting")
                        }
                    })
                }
            }
        }
    }
}
