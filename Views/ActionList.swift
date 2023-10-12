//
//  ActionList.swift
//  MemoryLane 2
//  Created by Marlon Grandy on 10/20/22.
//
//  This view provides actions related to memories,
//  such as uploading a photo and sharing a prompt.

import SwiftUI
import PhotosUI

// Ensuring this struct is available for iOS 16.0 and later.
@available(iOS 16.0, *)
struct ActionList: View {
    // State property to keep track of the selected photo item from PhotosPicker.
    @State private var selectedItem: PhotosPickerItem?
    
    // Binding to the photo data that will be used elsewhere in the application.
    @Binding var selectedPhotoData: Data?
    
    // State property to store the current prompt.
    @State var currentPrompt: String
    
    var body: some View {
        HStack {
            // Use PhotosPicker to allow users to pick an image from their photo library.
            PhotosPicker(
                selection: $selectedItem,
                matching: .images) {
                    Text("Upload\nPhoto")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundColor(Color.black)
                        .opacity(0.75)
                }
            // When the selected item changes, retrieve the image data.
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedPhotoData = data
                        }
                    }
                }
            
            // Provide spacing between the two action buttons.
            Spacer()
            Spacer()
            
            // Allow users to share the current prompt with others.
            ShareLink(item: "", subject: Text("MemoryLn. Prompt"), message: Text("Today's MemoryLn. prompt is '\(currentPrompt)'. Do you have any ideas of what I should answer the prompt with?")) {
                Label("Share", systemImage: "noImageShowing")
                    .font(.system(size: 20, weight: .semibold, design: .serif))
                    .foregroundColor(Color.black)
                    .opacity(0.75)
            }
            
            Spacer()
        }
        // Button("Share Prompt", action: //share)
    }
}

