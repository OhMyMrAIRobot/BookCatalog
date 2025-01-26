//
//  AuthView.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import SwiftUI

struct AuthView : View {
    @EnvironmentObject var authController : AuthController
    @State private var email : String = ""
    @State private var password : String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
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
                
                Spacer()
                
                VStack {
                    // Button "Sign in"
                    Button{
                        authController.signIn(email: email, password: password)
                    } label: {
                        Text("Sign In")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .fill(.black))
                            .padding()
                    }
                
                    
                    // Button "Register"
                    Button(action: {}) {
                        NavigationLink(destination: RegisterView()
                            .environmentObject(authController)
                            .navigationBarBackButtonHidden(true)) {
                                Text("Register")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.gray)
                        }
                    }
                }.padding(.bottom, 35)
                
            }
        }
    }
}


#Preview {
    AuthView()
}
