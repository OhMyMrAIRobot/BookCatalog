//
//  AuthController.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import Foundation

class AuthController : ObservableObject {
    
    var authService = AuthService()
    @Published var isSignedIn = false
    
    func register(email: String, password: String, age: Int) {
        authService.register(email: email, password: password) { result in
            switch result {
            case .success(let isSuccess):
                if isSuccess {
                    self.isSignedIn = true
                    print("Registered!")
                }
            case .failure(let error):
                print("Fail during registration: \(error.localizedDescription)")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        authService.signIn(email: email, password: password) { result in
            switch result {
            case .success(let isSuccess):
                if isSuccess {
                    self.isSignedIn = true
                    print("Signed in success")
                }
            case .failure(let error):
                print("Fail during sign in: \(error.localizedDescription)")
            }
        }
    }
}
