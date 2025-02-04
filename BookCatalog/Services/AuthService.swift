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
    
    @MainActor
    func signIn(email: String, password: String) async throws -> () {
        do {
            try await auth.signIn(withEmail: email, password: password)
            self.isLoggedIn = true
            return
        } catch {
            throw error
        }
    }
    
    @MainActor
    func register(email: String, password: String, age: Int) async throws -> () {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            let profile = Profile(id: result.user.uid, email: email, age: age)
            try await DatabaseService.shared.setProfile(profile: profile)
            self.isLoggedIn = true
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
        return auth.currentUser != nil
    }
    
    func getUserId() -> String? {
        return auth.currentUser?.uid
    }
}
