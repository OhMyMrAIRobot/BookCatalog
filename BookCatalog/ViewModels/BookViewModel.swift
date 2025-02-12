//
//  BookViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import Foundation

class BookViewModel: ObservableObject {
    private let reviewService: ReviewService
    
    @Published var userId: String
    @Published var book: Book
    @Published var author: Author
    @Published var genre: Genre
    @Published var language: BookLanguage
    @Published var reviews: [Review] = []
    @Published var rating: Double
    @Published var firstReviewId: String? = nil
    @Published var selectedSortOption: ReviewSortOption = .dateDescending {
        didSet {
            sortReviews()
        }
    }
    
    @Published var selectedRating: Int? = nil {
        didSet {
            updateFirstReview()
        }
    }
    
    enum ReviewSortOption: String, CaseIterable {
        case dateDescending = "Date descending (Newest first)"
        case dateAscending = "Date ascending (Oldest first)"
        case ratingDescending = "Rating (High to Low)"
        case ratingAscending = "Rating (Low to High)"
    }
    
    
    init(container: ServiceContainer, book: Book, author: Author, genre: Genre, language: BookLanguage, rating: Double) {
        self.reviewService = container.reviewService
        self.book = book
        self.author = author
        self.genre = genre
        self.language = language
        self.rating = rating
        self.userId = AuthService.shared.getUserId() ?? ""
    }
    
    @MainActor
    func fetchReviews() async {
        do {
            reviews = try await reviewService.getReviewsByBookId(bookId: book.id)
            sortReviews()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func postReview(review: Review) async -> Review? {
        do {
            let result = try await reviewService.setReview(review: review)
            if let index = reviews.firstIndex(where: { $0.id == result.id }) {
                reviews[index] = result
            } else {
                reviews.append(result)
            }
            
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    @MainActor
    func deleteReview(reviewId: String) async {
        do {
            try await reviewService.deleteReview(reviewId: reviewId)
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
        
        updateFirstReview()
    }
    
    
    func updateFirstReview() {
        if selectedRating == nil, let userReviewId = reviews.firstIndex(where: {$0.userId == userId}) {
            let userReview = reviews.remove(at: userReviewId)
            reviews.insert(userReview, at: 0)
            firstReviewId = reviews.first?.id
            return
        }
        
        if let firstId = reviews.firstIndex(where: {$0.rating == selectedRating}) {
            firstReviewId = reviews[firstId].id
        }
    }
}
