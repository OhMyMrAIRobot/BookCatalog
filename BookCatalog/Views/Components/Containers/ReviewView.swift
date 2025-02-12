//
//  ReviewView.swift
//  BookCatalog
//
//  Created by Daniil on 3.02.25.
//

import SwiftUI

struct ReviewView: View {
    let review: Review
    let profile: Profile
    let userId = AuthService.shared.getUserId()
    
    @EnvironmentObject var bookViewModel: BookViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.name.isEmpty && profile.surname.isEmpty ?
                         "Unknown user"
                         : "\(profile.name) \(profile.surname)")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundStyle(.black)
                    
                    Text(review.date.dateValue().formatted(date: .numeric, time: .omitted))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < review.rating ? "star.fill" : "star")
                            .bold()
                            .foregroundStyle(index < review.rating ? .yellow : .gray)
                    }
                }
                
                if review.userId == userId {
                    Image(systemName: "trash")
                        .bold()
                        .foregroundColor(.black)
                        .onTapGesture {
                            Task {
                                await bookViewModel.deleteReview(reviewId: review.id)
                                ratingViewModel.updateBookRating(bookId: bookViewModel.book.id, reviews: bookViewModel.reviews)
                            }
                        }
                }

            }
            
            ExpandableTextView(fullText: review.text, lines: 2)
            
            Divider()
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .purple, radius: 2, x: 0, y: 2)
    }
}
