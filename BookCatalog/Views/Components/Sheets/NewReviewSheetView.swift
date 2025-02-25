//
//  NewReviewSheetView.swift
//  BookCatalog
//
//  Created by Daniil on 3.02.25.
//

import SwiftUI

struct NewReviewSheetView: View {
    @Binding var isPresented: Bool
    let sheetTitle: String
    let bookTitle: String
    let name: String
    @State private var review: Review?
    @State private var rating: Int
    @State private var reviewText: String
    
    @EnvironmentObject var bookViewModel: BookViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    init(isPresented: Binding<Bool>, sheetTitle: String, bookTitle: String, name: String, review: Review?) {
        _isPresented = isPresented
        self.sheetTitle = sheetTitle
        self.bookTitle = bookTitle
        self.name = name
        _review = State(initialValue: review)
        _rating = State(initialValue: review?.rating ?? 0)
        _reviewText = State(initialValue: review?.text ?? "")
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("How would you rate")
                .font(.title)
                .bold()
            
            Text(bookTitle)
                .font(.headline)
                .fontWeight(.medium)
                .lineLimit(1)
            
            HStack {
                ForEach(1..<6) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .foregroundColor(index <= rating ? .yellow : .gray)
                        .font(.title)
                        .bold()
                        .onTapGesture {
                            rating = index
                        }
                }
            }
            
            TextEditor(text: $reviewText)
                .frame(height: 100)
                .padding(8)
                .accentColor(.black)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    
                    Text("(from your profile)")
                        .font(.system(size: 14))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
            
            HStack(spacing: 10) {
                PostReviewButtonView(title: "Cancel") { isPresented = false }
                
                PostReviewButtonView(title: sheetTitle, isInvert: false, isDisabled: rating == 0 || reviewText.isEmpty) {
                    Task {
                        var newReview = Review(bookId: bookViewModel.book.id, rating: rating, text: reviewText)
                        newReview.id = review?.id ?? newReview.id
                        if let result = await bookViewModel.postReview(review: newReview) {
                            await profileViewModel.fetchReviewProfiles(reviews: [result])
                        }
                        ratingViewModel.updateBookRating(bookId: bookViewModel.book.id, reviews: bookViewModel.reviews)
                        bookViewModel.sortReviews()
                        isPresented = false
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white.opacity(0.9))
    }
}
