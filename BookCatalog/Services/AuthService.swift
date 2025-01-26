//
//  AuthService.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation
import FirebaseAuth

class AuthService : ObservableObject {
    
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error!)
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error!)
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
    
    func isAuth() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
