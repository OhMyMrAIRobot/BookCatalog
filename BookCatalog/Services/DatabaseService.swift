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
    
    private var bookLgnsRef: CollectionReference {
        return db.collection("Languages")
    }
    
    private var authorsRef: CollectionReference {
        return db.collection("Authors")
    }
    
    private init() {}
    
    func createProfile(profile: Profile, completion: @escaping (Result <Profile, Error>) -> ()) {
        profilesRef.document(profile.id).setData(profile.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(profile))
            }
        }
    }
    
    func getBookLanguages(completion: @escaping (Result <[String: BookLanguage], Error>) -> ()) {
        bookLgnsRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snap = snapshot else {
                completion(.failure(NSError(domain: "FirestoreError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No snapshot found"])))
                return
            }
            
            var bookLanguageDict: [String: BookLanguage] = [:]
            
            for document in snap.documents {
                let data = document.data()
                
                if let lang = BookLanguage(data: data) {
                    bookLanguageDict[lang.id] = lang
                }
            }
           // print(bookLanguageDict)
            completion(.success(bookLanguageDict))
        }
    }
    
    func getAuthorById(authorId: String, completion: @escaping (Result <Author, Error>) -> ()) {
        authorsRef.document(authorId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document,
                document.exists,
                let data = document.data(),
                let author = Author(data: data)
            else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Author not found"])))
                return
            }
            
            completion(.success(author))
        }
    }
}
