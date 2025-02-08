//
//  RegisterView.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import SwiftUI

struct RegisterView : View {
    @State private var showAlert = false
    @State private var errorMsg = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var age : Double = 6
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Alerts
                ErrorAlert(showAlert: $showAlert, title: "Warning!", message: errorMsg, dismissButtonText: "Close")
                
                // Image
                Image("Book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 30.0)

                
                // Title
                HStack {
                    Spacer()
                    Text("EXAMPLE TITLE")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding(.top, 20.0)
                
                // Email
                HStack {
                    Image(systemName: "envelope")
                    TextField("Email", text: $email)
                        .tint(.black)
                    Spacer()
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black))
                .padding()
                
                // Password
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                        .tint(.black)
                    Spacer()
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black))
                .padding()
                
                // Age
                VStack(spacing: 10) {
                     Text("Select Your Age")
                        .font(.title)
                     
                     Text("Age: \(Int(age))")
                        .font(.largeTitle)
                        .bold()
                     
                     Slider(
                         value: $age,
                         in: 0...100,
                         step: 1
                     )
                     .accentColor(.black)
                     .padding(.horizontal)
                     .padding(.bottom, 35)
                 }
                
                // Button "Register"
                Button{
                    Task {
                        do {
                            try await AuthService.shared.register(email: email, password: password, age: Int(age))
                        } catch {
                            errorMsg = error.localizedDescription
                            showAlert.toggle()
                        }
                    }
                } label: {
                    Text("Register")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(.black))
                        .padding()
                }
                
                // Button "Sign in"
                Button(action: {}) {
                    NavigationLink(destination: AuthView()
                        .navigationBarBackButtonHidden(true)) {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
//                              .underline()
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    RegisterView()
}
