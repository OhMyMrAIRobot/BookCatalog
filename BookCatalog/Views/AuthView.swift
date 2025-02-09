//
//  AuthView.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import SwiftUI

struct AuthView : View {
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var showAlert = false
    @State private var errorMsg = ""
    @EnvironmentObject var serviceContainer: ServiceContainer
    var body: some View {

        VStack {
            ErrorAlert(showAlert: $showAlert, title: "Warning!", message: errorMsg, dismissButtonText: "Close")
            
            Image("Book")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 30.0)
            
            HStack {
                Spacer()
                Text("EXAMPLE TITLE")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.top, 20.0)
            
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
                Button{
                    Task {
                        do {
                            try await AuthService.shared.signIn(email: email, password: password)
                        } catch {
                            print(error.localizedDescription)
                            errorMsg = error.localizedDescription
                            showAlert.toggle()
                        }
                    }
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
                
                
                Button(action: {}) {
                    NavigationLink(destination: RegisterView(serviceContainer: serviceContainer)
                        .navigationBarBackButtonHidden(false)) {
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

#Preview {
    AuthView()
}
