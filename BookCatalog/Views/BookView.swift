//
//  BookView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.

import SwiftUI
import FirebaseAuth

struct BookView: View {
    @StateObject var bookViewModel: BookViewModel
    
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @State private var selectedRating: Int? = nil

    var body: some View {
        ScrollView() {
            AsyncImage(url: URL(string: bookViewModel.book.images.isEmpty ?
                                "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png"
                                :  bookViewModel.book.images[0])) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Text("Failed to load image")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: 200, maxHeight: 300)
            .clipped()
            .cornerRadius(10)
            
            
            Text(bookViewModel.book.title)
                .frame(maxWidth: 350)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
         
            Text("\(bookViewModel.author.name) \(bookViewModel.author.surname)")
                .font(.system(size: 22))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .padding(.top, 5)
            
            Divider()
            
            HStack(alignment: .center) {
                HStack(spacing: 1.5) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 24))
                        .bold()
                    
                    Text(String(format: "%.1f", ratingViewModel.bookRatings[bookViewModel.book.id] ?? 0.0))
                        .font(.system(size: 24))
                        .bold()
                }.padding(.horizontal, 7)
                
                // TODO: добавить язык книги
                
                HStack(spacing: 1.5) {
                    Image(systemName: "exclamationmark.shield.fill")
                        .foregroundColor(getAgeColor(age: bookViewModel.book.ageRestriction))
                        .font(.system(size: 24))
                        .bold()
                    
                    Text("\(bookViewModel.book.ageRestriction)+")
                        .font(.system(size: 24))
                        .bold()
                }
                
                Spacer()
                
                Text(bookViewModel.genre.name)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 3)
                    .background(Color.red.opacity(0.2))
                    .foregroundColor(Color.red.opacity(0.9))
                    .clipShape(Capsule())
                    .padding(.horizontal, 10)
                
            
                Button(action: {
                    Task {
                        await favouriteViewModel.toggleFavouriteBook(bookId: bookViewModel.book.id)
                    }
                }) {
                    Image(systemName: favouriteViewModel.favouriteBookIds.contains(bookViewModel.book.id) ? "heart.fill" : "heart")
                        .foregroundColor(favouriteViewModel.favouriteBookIds.contains(bookViewModel.book.id) ? .red : .gray)
                        .font(.system(size: 30))
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            ExpandableTextView(fullText: bookViewModel.book.description, lines: 5)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .padding(.top, 10)
            
            Divider()
            
            ImageCarouselView(book: bookViewModel.book)
                .padding(.top, 10)
            
            Divider()
                .padding(.top, 10)
    
            ReviewFiltersBarView(selectedRating: $selectedRating)
                .environmentObject(bookViewModel)

            VStack(spacing: 20) {
                ForEach(bookViewModel.reviews.filter { selectedRating == nil || $0.rating == selectedRating }) { review in
                    ReviewView(review: review,
                               profile: profileViewModel.reviewProfiles[review.userId] ?? Profile(id: "", email: "", age: 0),
                               userId: profileViewModel.userId
                    )
                    .environmentObject(bookViewModel)
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(Color(.systemGray6))
        .scrollIndicators(.hidden)
        .onAppear {
            Task {
                await bookViewModel.fetchReviews()
                await profileViewModel.fetchReviewProfiles(reviews: bookViewModel.reviews)
            }
        }
    }
    
    func getAgeColor(age: Int) -> Color {
        switch age {
        case ...6: return .green
        case 7...17: return .orange
        default: return .red
        }
    }
}
