//
//  ReviewService.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import FirebaseFirestore

class ReviewService {
    private let db: Firestore
    
    init(databaseService: DatabaseService) {
        self.db = databaseService.db
    }
    
    private var reviewsRef: CollectionReference { return db.collection("Reviews") }
    
    
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
        guard let userId = AuthService.shared.getUserId() else {
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
    
    
    func deleteReview(reviewId: String) async throws {
        do {
            try await reviewsRef.document(reviewId).delete()
        } catch {
            throw error
        }
    }
    
    
    func deleteUserReviews() async throws {
        guard let userId = AuthService.shared.getUserId() else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user id found"])
        }
        
        do {
            let querySnapshot = try await reviewsRef
                .whereField("userId", isEqualTo: userId)
                .getDocuments()
            
            for document in querySnapshot.documents {
                try await reviewsRef.document(document.documentID).delete()
            }
            
        } catch {
            throw error
        }
    }
}
