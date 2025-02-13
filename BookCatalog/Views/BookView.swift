//
//  BookView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import SwiftUI
import FirebaseAuth

struct BookView: View {
    @StateObject var bookViewModel: BookViewModel
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                VStack {
                    BookImageView(imageUrl: !bookViewModel.book.images.isEmpty ? bookViewModel.book.images[0] : "")
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 200, height: 300)
                        .clipped()
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: -2, y: 2)

                    Text("\(bookViewModel.book.title) (\(String(bookViewModel.book.publishedYear)))")
                        .frame(maxWidth: 350)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .font(.title)
                        .bold()
                        .padding(.top, 15)

                    Text("\(bookViewModel.author.name) \(bookViewModel.author.thirdname.isEmpty ? "" : bookViewModel.author.thirdname + " ")\(bookViewModel.author.surname)")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.top, 3)
            

                    VStack(spacing: 10) {
                        Divider()

                        HStack(alignment: .center) {
                            BookRatingView(fontSize: 24, rating: ratingViewModel.bookRatings[bookViewModel.book.id] ?? 0.0)

                            TagButtonView(title: bookViewModel.genre.name, fontSize: 18) {}
                            TagButtonView(title: bookViewModel.language.name, fontSize: 18) {}
                            AgeRestictionCircleView(age: bookViewModel.book.ageRestriction, radius: 32, fontSize: 17).bold()

                            Spacer()

                            FavouriteToggleButtonView(isFavourite: favouriteViewModel.favouriteBookIds.contains(bookViewModel.book.id)) {
                                Task { await favouriteViewModel.toggleFavouriteBook(bookId: bookViewModel.book.id) }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        ExpandableTextView(fullText: bookViewModel.book.description, lines: 5)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)

                        Divider()

                        ImageCarouselView(book: bookViewModel.book)

                        Divider()

                        ReviewFiltersBarView(selectedRating: $bookViewModel.selectedRating)
                            .environmentObject(bookViewModel)
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: .purple, radius: 2, x: 0, y: 2)
                            .onChange(of: bookViewModel.selectedRating) {
                                scrollToFirstReview(scrollProxy)
                            }
                            .onChange(of: ratingViewModel.bookRatings[bookViewModel.book.id]) {
                                scrollToFirstReview(scrollProxy)
                            }

                        VStack(spacing: 20) {
                            ForEach(bookViewModel.reviews.filter { bookViewModel.selectedRating == nil || $0.rating == bookViewModel.selectedRating }) { review in
                                if let profile = profileViewModel.reviewProfiles[review.userId] {
                                    ReviewView(review: review, profile: profile)
                                        .environmentObject(bookViewModel)
                                        .id(review.id)
                                } else {
                                    Text("error ")
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
                .padding(.top, 70)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .scrollIndicators(.hidden)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color.gradientColor)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButtonView())
            .onAppear {
                Task {
                    await bookViewModel.fetchReviews()
                    await profileViewModel.fetchReviewProfiles(reviews: bookViewModel.reviews)
                }
            }
        }
    }

    private func scrollToFirstReview(_ proxy: ScrollViewProxy) {
        if let firstReviewId = bookViewModel.firstReviewId {
            withAnimation {
                proxy.scrollTo(firstReviewId, anchor: .top)
            }
        }
    }
}
