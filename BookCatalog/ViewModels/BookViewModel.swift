//
//  BookViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import Foundation

class BookViewModel: ObservableObject {
    @Published var book: Book
    @Published var author: Author
    @Published var genre: Genre
    @Published var language: BookLanguage
    @Published var reviews: [Review] = []
    @Published var profiles: [String: Profile] = [:]
    @Published var rating: Double
    
    init(book: Book, author: Author, genre: Genre, language: BookLanguage, rating: Double) {
        self.book = book
        self.author = author
        self.genre = genre
        self.language = language
        self.rating = rating
    }
    
    @MainActor
    func fetchReviews() async {
        do {
            reviews = try await DatabaseService.shared.getReviewsByBookId(bookId: book.id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchProfiles() async {
        for review in reviews {
            do {
                let profile = try await DatabaseService.shared.getProfileById(profileId: review.userId)
                profiles[profile.id] = profile
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func postReview(rating: Int, text: String) async {
        let review = Review(bookId: book.id, rating: rating, text: text)
        do {
            try await DatabaseService.shared.setReview(review: review)
            reviews.append(review)
        } catch {
            print(error.localizedDescription)
        }
    }
}
