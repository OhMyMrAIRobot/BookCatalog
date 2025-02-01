//
//  DatabaseService.swift
//  BookCatalog
//
//  Created by Daniil on 27.01.25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

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
    
    private var genresRef: CollectionReference {
        return db.collection("Genres")
    }
    
    private var booksRef: CollectionReference {
        return db.collection("Books")
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
    
    
    func getProfileById(profileId: String, completion: @escaping (Result <Profile, Error>) -> ()) {
        profilesRef.document(profileId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document,
                  document.exists,
                  let data = document.data(),
                  let profile = Profile(data: data)
            else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])))
                return
            }
            
            completion(.success(profile))
        }
    }
    
    
    func getBookLanguages(completion: @escaping (Result <[String: BookLanguage], Error>) -> ()) {
        bookLgnsRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snap = snapshot else {
                completion(.failure(NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No snapshot found"])))
                return
            }
            
            var bookLanguagesDict: [String: BookLanguage] = [:]
            
            for document in snap.documents {
                let data = document.data()
                
                if let lang = BookLanguage(data: data) {
                    bookLanguagesDict[lang.id] = lang
                }
            }
           // print(bookLanguagesDict)
            completion(.success(bookLanguagesDict))
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
    
    
    func getGenres(completion: @escaping (Result <[String: Genre], Error>) -> ()) {
        genresRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snap = snapshot else {
                completion(.failure(NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No snapshot found"])))
                return
            }
            
            var genresDict : [String: Genre] = [:]

            for document in snap.documents {
                let data = document.data()
                
                if let genre = Genre(data: data) {
                    genresDict[genre.id] = genre
                }
            }
            
            completion(.success(genresDict))
        }
    }
    
    
    func getBooks(completion: @escaping (Result <[Book], Error>) -> ()) {
        booksRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snap = snapshot else {
                completion(.failure(NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No snapshot found"])))
                return
            }
            
            var books : [Book] = []
            
            for document in snap.documents {
                let data = document.data()
                
                if let book = Book(data: data) {
                    books.append(book)
                }
            }
            
            completion(.success(books))
        }
    }
    
    func toggleFavouriteBook(bookId: String, completion: @escaping(Bool) -> ()) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        profilesRef.document(userId).getDocument { document, error in
            guard let document = document,
                  document.exists,
                  let data = document.data()
            else {
                completion(false)
                return
            }
            
            var favouriteBookIds = data["favBookIds"] as? [String] ?? []
            if favouriteBookIds.contains(bookId) {
                favouriteBookIds.removeAll { $0 == bookId }
            } else {
                favouriteBookIds.append(bookId)
            }
            
            self.profilesRef.document(userId).updateData(["favBookIds": favouriteBookIds]) { error in
                completion(error == nil)
                return
            }
        }
    }
    
    
    func getFavouriteBookIds(completion: @escaping(Result<[String], Error>) -> ()) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user id found"])))
            return
        }
        
        profilesRef.document(userId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document,
                  document.exists,
                  let data = document.data()
            else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])))
                return
            }
            
            if let favouriteBookIds = data["favBookIds"] as? [String] {
                completion(.success(favouriteBookIds))
            } else {
                completion(.failure(NSError(domain: "Firestore", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid data format for favBookIds"])))
            }
        }
    }
}
