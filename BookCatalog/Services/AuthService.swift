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
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
                self.isLoggedIn = true
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func register(email: String, password: String, age: Int, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                
                let profile = Profile(id: result.user.uid,
                                      email: email,
                                      age: age)
                DatabaseService.shared.createProfile(profile: profile) { dbResult in
                    switch dbResult{
                    case .success(_):
                        completion(.success(result.user))
                        self.isLoggedIn = true
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            } else if let error = error {
                completion(.failure(error))
            }
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
