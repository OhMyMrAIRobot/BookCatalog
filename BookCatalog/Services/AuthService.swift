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
    @Published var isLoading: Bool = true
    
    private init() {
        Task { @MainActor in
            self.isLoggedIn = self.isAuth()
            self.isLoading = false  // Завершаем проверку
        }
//        Auth.auth().addStateDidChangeListener { _, user in
//            DispatchQueue.main.async {
//                self.isLoggedIn = (user != nil)
//            }
//        }
    }
    
    @MainActor
    func signIn(email: String, password: String) async throws {
        do {
            try await auth.signIn(withEmail: email, password: password)
            self.isLoggedIn = true
            return
        } catch {
            throw error
        }
    }
    
    @MainActor
    func register(email: String, password: String) async throws -> User {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            self.isLoggedIn = true
            return result.user
        } catch {
            throw error
        }
    }
    
    @MainActor
    func signOut() throws {
        do {
            try auth.signOut()
            self.isLoggedIn = false
        } catch {
            throw error
        }
    }
    
    @MainActor
    func deleteUser() async throws {
        do {
            try await auth.currentUser?.delete()
            self.isLoggedIn = false
        } catch {
            throw error
        }
    }
    
    
    func isAuth() -> Bool {
        return auth.currentUser != nil
    }
    
    func getUserId() -> String? {
        return auth.currentUser?.uid
    }
}
