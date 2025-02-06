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
    @Published var selectedSortOption: ReviewSortOption = .dateDescending {
        didSet {
            sortReviews()
        }
    }
    
    enum ReviewSortOption: String, CaseIterable {
        case dateDescending = "Date descending (Newest first)"
        case dateAscending = "Date ascending (Oldest first)"
        case ratingDescending = "Rating (High to Low)"
        case ratingAscending = "Rating (Low to High)"
    }
    
    
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
            sortReviews()
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
    func postReview(review: Review) async {
        do {
            let result = try await DatabaseService.shared.setReview(review: review)
            if let index = reviews.firstIndex(where: { $0.id == result.id }) {
                reviews[index] = result
            } else {
                reviews.append(result)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func deleteReview(reviewId: String) async {
        do {
            try await DatabaseService.shared.deleteReview(reviewId: reviewId)
            reviews.removeAll { $0.id == reviewId }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func sortReviews() {
        switch selectedSortOption {
        case .dateDescending:
            reviews.sort { $0.date.dateValue() > $1.date.dateValue() }
        case .dateAscending:
            reviews.sort { $0.date.dateValue() < $1.date.dateValue() }
        case .ratingDescending:
            reviews.sort { $0.rating > $1.rating }
        case .ratingAscending:
            reviews.sort { $0.rating < $1.rating }
        }
    }
}
