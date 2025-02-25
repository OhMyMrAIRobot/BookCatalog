//
//  RatingViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 4.02.25.
//

import Foundation

class RatingViewModel: ObservableObject {
    private let reviewService: ReviewService
    
    init(container: ServiceContainer) {
        self.reviewService = container.reviewService
    }
    
    @Published var bookRatings : [String: Double] = [:]
    
    @MainActor
    func fetchBookRatings(books: [Book]) async {
//        for book in books {
//            do {
//                let reviews = try await reviewService.getReviewsByBookId(bookId: book.id)
//                
//                let sum = reviews.reduce(0) { $0 + $1.rating }
//                bookRatings[book.id] = reviews.isEmpty ? 0.0 : Double(sum) / Double(reviews.count)
//            } catch {
//                print("Failed to fetch rating for book \(book.id): \(error.localizedDescription)")
//                bookRatings[book.id] = 0.0
//            }
//        }
        do {
            bookRatings = try await reviewService.getRatings(books: books)
        } catch {
            print(error)
        }
    }
    
    func updateBookRating(bookId: String, reviews: [Review]) {
        guard !reviews.isEmpty else {
            bookRatings[bookId] = 0.0
            return
        }
        let rating = reviews.map { Double($0.rating) }.reduce(0, +) / Double(reviews.count)
        bookRatings[bookId] = rating
    }
    
}
