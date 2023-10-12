//
//  TextEditorFormat.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/12/22.
//
//  This file defines a custom text editor modifier that can be applied to SwiftUI views.
//  The modifier allows the customization of the appearance of text fields, such as their padding,
//  border color, and line width. The customTextField extension function makes it convenient to apply
//  this modifier to any SwiftUI view.

import Foundation
import SwiftUI

/// A custom view modifier that adds a customizable border to text fields.
struct TextFieldModifier: ViewModifier {
    let color: Color          // Border color
    let padding: CGFloat      // Padding around the text field
    let lineWidth: CGFloat    // Width of the border line
    
    /// Modifies the provided content (i.e., text field) with custom padding and border properties.
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(RoundedRectangle(cornerRadius: padding)
                .stroke(color, lineWidth: lineWidth)
            )
    }
}

extension View {
    /// Conveniently applies the custom `TextFieldModifier` to any SwiftUI view, enabling the customization of the text field appearance.
    ///
    /// - Parameters:
    ///   - color: The color of the border.
    ///   - padding: The amount of padding around the text field.
    ///   - lineWidth: The width of the border line.
    ///
    /// - Returns: A view with the applied custom text field appearance.
    func customTextField(color: Color = .clear, padding: CGFloat = 10, lineWidth: CGFloat = 1.0) -> some View {
        self.modifier(TextFieldModifier(color: color, padding: padding, lineWidth: lineWidth))
    }
}
