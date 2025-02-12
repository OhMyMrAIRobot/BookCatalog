//
//  AuthFormView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct AuthFormView: View {
    @StateObject private var authViewModel: AuthViewModel
    
    init(serviceContainer: ServiceContainer) {
        _authViewModel = StateObject(wrappedValue: AuthViewModel(container: serviceContainer))
    }
    
    @State private var isAuthView = true
    @State private var showAlert = false
    @State private var errorMsg = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var age : Double = 6
    
    var body: some View {
        ErrorAlert(showAlert: $showAlert, title: "Warning!", message: errorMsg, dismissButtonText: "Close")
        
        UnevenRoundedRectangle(cornerRadii: .init(
            topLeading: 35.0,
            bottomLeading: 0.0,
            bottomTrailing: 0.0,
            topTrailing: 35.0),
            style: .continuous)
        .frame(maxWidth: .infinity, maxHeight: isAuthView ? 500 : 600)
        .foregroundStyle(.white)
        .overlay(
            VStack(alignment: .center, spacing: 40) {
                Text("TiTle Title")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color.gradientColor)
                
                VStack(spacing: 30) {
                    UnderlinedTextFieldView(icon: "envelope", placeholder: "Email", text: $email)
                    
                    UnderlinedTextFieldView(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                    
                    if !isAuthView {
                        VStack(spacing: 2) {
                            
                            Text("Age: \(Int(age))")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.gradientColor)

                            Slider(
                                value: $age,
                                in: 0...100,
                                step: 1
                            )
                            .accentColor(Color(red: 170 / 255, green: 150 / 255, blue: 250 / 255))
                        }
                    }
                }

                VStack(spacing: 15) {
                    SignButtonView(title: isAuthView ? "Login" : "Sign up") {
                        Task {
                            do {
                                if isAuthView {
                                    try await AuthService.shared.signIn(email: email, password: password)
                                } else {
                                    try await authViewModel.register(email: email, password: password, age: Int(age))
                                }
                            } catch {
                                print(error.localizedDescription)
                                errorMsg = error.localizedDescription
                                showAlert.toggle()
                            }
                        }
                    }
                    
                    Text("OR")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    SignButtonView(title: isAuthView ? "Sign up" : "Login", invert: true) {
                        isAuthView.toggle()
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .animation(.easeInOut(duration: 0.3), value: isAuthView)
        )
    }
}
