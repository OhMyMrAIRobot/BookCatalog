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
    
    private var profilesRef: CollectionReference { return db.collection("Profiles") }
    private var bookLgnsRef: CollectionReference { return db.collection("Languages") }
    private var authorsRef: CollectionReference { return db.collection("Authors") }
    private var genresRef: CollectionReference { return db.collection("Genres") }
    private var booksRef: CollectionReference { return db.collection("Books") }
    private var reviewsRef: CollectionReference { return db.collection("Reviews") }
    
    
    private init() {}
    
    
    func setProfile(profile: Profile) async throws -> () {
        do {
            try profilesRef.document(profile.id).setData(from: profile)
        } catch {
            throw error
        }
    }
    
    
    func getProfileById(profileId: String) async throws -> Profile {
        let document = try await profilesRef.document(profileId).getDocument()
        
        guard let profile = try? document.data(as: Profile.self) else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])
        }
        
        return profile
    }
    
    
    func getBookLanguages() async throws -> [String: BookLanguage] {
        let snapshot = try await bookLgnsRef.getDocuments()
        
        var languages: [String: BookLanguage] = [:]
        
        for document in snapshot.documents {
            if let language = try? document.data(as: BookLanguage.self) {
                languages[language.id] = language
            }
        }
        
        return languages
    }
    
    
    func getAuthorById(authorId: String) async throws -> Author {
        let document = try await authorsRef.document(authorId).getDocument()
        
        guard let data = document.data(),
              let author = try? Firestore.Decoder().decode(Author.self, from: data)
        else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Author not found"])
        }
        
        return author
    }
    
    
    func getGenres() async throws -> [String: Genre] {
        let snapshot = try await genresRef.getDocuments()
        
        var genres: [String : Genre] = [:]
        
        for document in snapshot.documents {
            if let genre = try? document.data(as: Genre.self) {
                genres[genre.id] = genre
            }
        }
        
        return genres
    }
    
    
    func getBooks() async throws -> [Book] {
        let snapshot = try await booksRef.getDocuments()
        
        let books: [Book] = snapshot.documents.compactMap { document in
            return try? document.data(as: Book.self)
        }
        
        return books
    }
    
    
    func toggleFavouriteBook(bookId: String) async throws -> Bool {
        guard let userId = Auth.auth().currentUser?.uid else {
            return false
        }
        
        do {
            let document = try await profilesRef.document(userId).getDocument()
            
            guard document.exists,
                let data = document.data()
            else {
                return false
            }
            
            var favouriteBookIds = data["favBookIds"] as? [String] ?? []
            if favouriteBookIds.contains(bookId) {
                favouriteBookIds.removeAll { $0 == bookId }
            } else {
                favouriteBookIds.append(bookId)
            }

            try await profilesRef.document(userId).updateData(["favBookIds": favouriteBookIds])
            
            return true
        } catch {
            return false
        }
    }
    
    
    func getFavouriteBookIds() async throws -> [String] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user id found"])
        }
        
        let document = try await profilesRef.document(userId).getDocument()
        
        guard document.exists,
            let data = document.data()
        else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])
        }

        guard let favouriteBookIds = data["favBookIds"] as? [String] else {
            throw NSError(domain: "Firestore", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid data format for favBookIds"])
        }
        
        return favouriteBookIds
    }
    
    
    func getReviewsByBookId(bookId: String) async throws -> [Review] {
        let snapshot = try await reviewsRef
            .whereField("bookId", isEqualTo: bookId)
            .getDocuments()
        
        var reviews: [Review] = []
        for document in snapshot.documents {
            if let review = try? document.data(as: Review.self) {
                reviews.append(review)
            }
        }
        return reviews
    }
    
    
    func setReview(review: Review) async throws -> Review {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user id found"])
        }
        do {
            var newReview = review
            newReview.userId = userId
            newReview.date = Timestamp(date: .now)
            
            try reviewsRef.document(review.id).setData(from: newReview)
            return newReview
        } catch {
            throw error
        }
    }
}
