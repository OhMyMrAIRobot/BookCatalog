//
//  AuthService.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation
import FirebaseAuth

class AuthService : ObservableObject {
    
    static let shared = AuthService()
    private let auth = Auth.auth()
    @Published var isLoggedIn: Bool = false
    
    private init() {
        self.isLoggedIn = isAuth()
//        Auth.auth().addStateDidChangeListener { _, user in
//            DispatchQueue.main.async {
//                self.isLoggedIn = (user != nil)
//            }
//        }
    }
    
    
    func signIn(email: String, password: String) async throws -> () {
        do {
            try await auth.signIn(withEmail: email, password: password)
            await MainActor.run {
                self.isLoggedIn = true
            }
            return
        } catch {
            throw error
        }
    }
    
    
    func register(email: String, password: String, age: Int) async throws -> () {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            let profile = Profile(id: result.user.uid, email: email, age: age)
            try await DatabaseService.shared.createProfile(profile: profile)
            await MainActor.run {
                self.isLoggedIn = true
            }
            return
        } catch {
            throw error
        }
    }
    
    
    func signOut() {
        do {
            try auth.signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
            }
        } catch {
            
        }
    }
    
    
    func isAuth() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
