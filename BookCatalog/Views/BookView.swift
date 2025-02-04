//
//  BookView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.

import SwiftUI

struct BookView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    @State private var selectedRating: Int? = nil
    @State private var isAddSheetActive = false
    
    @State private var reviewRating = 0
    @State private var reviewText = ""
    
    var body: some View {
        ScrollView() {
            AsyncImage(url: URL(string: bookViewModel.book.images.isEmpty ?
                                "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png"
                                :  bookViewModel.book.images[0])) { image in
                image.image?.resizable()
            }.frame(maxWidth: 200, maxHeight: 300)
                .clipped()
                .cornerRadius(10)
                .padding(.top, 15)
            
            
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
                    
                    Text(String(format: "%.1f", 5.0))
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

            HStack(alignment: .center) {
                Button(action: {
                    
                }) {
                    Image(systemName: "slider.horizontal.3")
                }
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white)
                .foregroundColor(.black)
                .clipShape(Capsule())
    
                Spacer()
                
                Button(action: {
                    isAddSheetActive.toggle()
                }) {
                    Text("+ Review")
                }
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.black)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .padding(.top, 10)
            .sheet(isPresented: $isAddSheetActive) {
                NewReviewSheetView(
                    isPresented: $isAddSheetActive,
                    sheetTitle: "Post new review",
                    bookTitle: bookViewModel.book.title,
                    name: "Name Surname",
                    rating: $reviewRating,
                    reviewText: $reviewText
                )
                .presentationDetents([.large, .fraction(0.8)])
                .presentationDragIndicator(.visible)
                .environmentObject(bookViewModel)
            }
    
            ReviewFiltersBar(selectedRating: $selectedRating)

            VStack(spacing: 20) {
                ForEach(bookViewModel.reviews.filter { selectedRating == nil || $0.rating == selectedRating }) { review in
                    ReviewView(review: review, profile: bookViewModel.profiles[review.userId] ?? Profile(id: "", email: "", age: 4))
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
                await bookViewModel.fetchProfiles()
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
