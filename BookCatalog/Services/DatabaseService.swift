//
//  DatabaseService.swift
//  BookCatalog
//
//  Created by Daniil on 27.01.25.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    private var profilesRef: CollectionReference {
        return db.collection("Profiles")
    }
    
    private init() {}
    
    func createProfile(profile: Profile, completion: @escaping (Result<Profile, Error>) -> ()) {
        profilesRef.document(profile.id).setData(profile.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(profile))
            }
        }
    }
}
