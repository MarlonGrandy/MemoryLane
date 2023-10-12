//
//  ContentView.swift
//  MemoryLane
//  Created by Marlon Grandy on 9/1/22.
//
//  This file contains the main content view of the application.
//  The `ContentView` determines whether to show the login screen or
//  the prompt screen based on the user's login state.

import SwiftUI

@available(iOS 16.0, *)
/// The main content view of the application.
///
/// This view checks the `isLogin` state to decide whether to display the login screen
/// or the prompt screen. If the user is not logged in (`isLogin` is `false`), the login screen
/// (`LoginView`) is displayed. Otherwise, the prompt screen (`PromptView`) is shown.
struct ContentView: View {
    
    @State var isLogin: Bool = false            // State variable to keep track of the user's login status.
    @Environment (\.managedObjectContext) var managedObjContext  // Core Data context for the app.
    
    var body: some View {
        if !isLogin {
            LoginView(isLogin: $isLogin)        // Display the login screen.
        } else {
            PromptView()                        // Display the prompt screen.
        }
    }
}
