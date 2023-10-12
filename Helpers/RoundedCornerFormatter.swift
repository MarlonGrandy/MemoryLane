//
//  RoundedCornerFormatter.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/12/22.
//
//  This file defines a custom `RoundedCorner` shape that can be used in SwiftUI views.
//  The `RoundedCorner` shape allows for specific corners of a rectangle to be rounded.
//  This provides a flexible solution for UI designs where not all corners of a view need to be rounded.

import SwiftUI

/// A custom shape for rounding specific corners of a rectangle.
///
/// Use this shape in SwiftUI views to achieve rounded corners on a subset of a rectangle's corners.
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity        // The radius of the rounded corners.
    var corners: UIRectCorner = .allCorners // The specific corners of the rectangle to round.
    
    /// Generates a path for the rounded rectangle, given the specified rounded corners.
    ///
    /// - Parameters:
    ///   - rect: The rectangle that needs its corners to be rounded.
    ///
    /// - Returns: A path representing the rounded rectangle.
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
