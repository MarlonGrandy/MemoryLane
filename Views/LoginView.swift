//
//  LoginView.swift
//  Shared
//  Created by Marlon Grandy on 8/30/22.
//
//  This file defines the login view for the application. It includes user
//  authentication features integrated with Firebase. The view allows users
//  to either login or create an account.

import SwiftUI
import Firebase

/// Manager class for Firebase authentication operations.
class FirebaseManager: NSObject {
    
    let auth: Auth
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
}

/// View structure for user login and account creation.
struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var isLoginMode = true          // Tracks if the view is in login mode or account creation mode.
    @Binding var isLogin: Bool             // Tracks if the user is logged in.
    
    var body: some View {
        VStack{
            // App title and design aesthetics.
            Text("Memory Ln.")
                .font(.system(size: 65, weight: .regular, design: .serif))
                .foregroundColor(Color.white)
                .padding(.bottom,20 )
            Divider()
                .background(Color.white)
            NavigationView {
                ScrollView {
                    VStack {
                        // Picker for toggling between login and create account modes.
                        Picker(selection: $isLoginMode, label: Text("Pick")) {
                            Text("Login")
                                .tag(true)
                                .font(.system(size: 20, weight: .semibold))
                            Text("Create Account")
                                .font(.system(size: 20, weight: .semibold))
                                .tag(false)
                                .background(Color.white)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.white)
                        .padding(5)
                        .padding(.bottom,50)
                        
                        // Email and password input fields.
                        Group {
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            SecureField("Password", text: $password)
                                .disableAutocorrection(true)
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        // Action button for either logging in or creating an account.
                        Button {
                            handleAction()
                        } label: {
                            HStack {
                                Spacer()
                                Text(isLoginMode ? "Log In" : "Create Account")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 35, weight: .semibold, design: .serif))
                                Spacer()
                            }
                        }
                        // Message displayed based on authentication actions.
                        Text(self.actMessage)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                }
                .background(Color.black, ignoresSafeAreaEdges: [.top, .bottom])
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .background(Color.black, ignoresSafeAreaEdges: [.top, .bottom])
    }
    
    // Function to handle authentication action based on mode (login or create account).
    private func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            createAccount()
        }
    }
    
    // Function to log the user in using Firebase authentication.
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user :( \(err)")
                self.actMessage = "Failed to login user :("
                return
            }
            
            print("Successfully logged in!")
            self.actMessage = "Successfully logged in!"
            self.isLogin = true
        }
    }
    
    @State var actMessage = ""
    
    // Function to create a new user account using Firebase authentication.
    private func createAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user")
                self.actMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successfully created user!")
            self.actMessage = "Successfully created user!"
        }
    }
}

// Preview provider for the SwiftUI canvas.
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLogin: .constant(false))
    }
}
