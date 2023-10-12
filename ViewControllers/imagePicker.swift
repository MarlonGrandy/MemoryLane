//
//  imagePicker.swift
//  MemoryLane 2
//  Created by Marlon Grandy on 10/20/22.
//
//  This file defines an ImagePicker view struct that allows the user to select an image
//  from their photo library and provides integration with SwiftUI views.

import Foundation
import PhotosUI
import SwiftUI

/// `ImagePicker` is a struct that provides an interface to pick images from the photo library using SwiftUI.
struct ImagePicker: UIViewControllerRepresentable {
    
    // Binding to the selected image data.
    @Binding var image: Data?
    
    /// Creates and returns a controller for the image picker interface.
    ///
    /// - Parameter context: A context that contains information to be used during view updates.
    /// - Returns: A `PHPickerViewController` configured for image selection.
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    /// Updates the view controller for the image picker interface.
    ///
    /// - Parameters:
    ///   - uiViewController: The view controller to update.
    ///   - context: A context that contains information to be used during view updates.
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // Currently empty as there is no required update logic.
        // This is necessary to conform to UIViewControllerRepresentable.
    }
    
    /// Creates a coordinator instance that manages the interactions between the `ImagePicker` and the `PHPickerViewController`.
    ///
    /// - Returns: A new `Coordinator` instance.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// `Coordinator` is a delegate class that handles the user's interactions within the image picker interface.
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        /// Handles the selection of images by the user from the photo library.
        ///
        /// - Parameters:
        ///   - picker: The image picker interface.
        ///   - results: The images selected by the user.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? Data
                }
            }
        }
    }
}
