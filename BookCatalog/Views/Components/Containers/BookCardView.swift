//
//  BookCardView.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import SwiftUI

struct BookCardView : View {
    let book: Book
    let author: Author
    let genre: Genre
    let rating: Double
    let language: BookLanguage
    @EnvironmentObject var favouriteViewModel : FavouriteViewModel
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var serviceContainer: ServiceContainer
    
    var body : some View {
        NavigationLink(destination: destinationView) {
            HStack(alignment: .top) {
                BookImageView(imageUrl: !book.images.isEmpty ? book.images[0] : "")
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(maxWidth: 90)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: -2, y: 2)

                VStack(alignment: .leading, spacing: 14) {
                    Text(book.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.black)
                    
                    Text("\(author.name) \(author.surname)")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.gray)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        TagButtonView(title: genre.name, fontSize: 15, action: {})
                        TagButtonView(title: language.name, fontSize: 15, action: {})
                    }
                }
                .padding(.leading, 10)
                .frame(width: 185)
                
                VStack(alignment: .trailing) {
                    BookRatingView(fontSize: 18, rating: rating)
                    
                    AgeRestictionCircleView(age: book.ageRestriction, radius: 30, fontSize: 14)
                    
                    FavouriteToggleButtonView(isFavourite: favouriteViewModel.favouriteBookIds.contains(book.id)) {
                            Task { await favouriteViewModel.toggleFavouriteBook(bookId: book.id) }
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                }
                .frame(width: 55)
            }
            .frame(maxHeight: 130)
            .padding(15)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .purple.opacity(0.7), radius: 2, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gradientColor, lineWidth: 1)
        )
    }
    
    var destinationView: some View {
        if let author = catalogViewModel.authors[book.authorId],
           let genre = catalogViewModel.genres[book.genreId],
           let language = catalogViewModel.languages[book.languageId],
           let rating = ratingViewModel.bookRatings[book.id] {
            return AnyView(
                BookView(bookViewModel: BookViewModel(
                    container: serviceContainer,
                    book: book,
                    author: author,
                    genre: genre,
                    language: language,
                    rating: rating
                ))
                .environmentObject(ratingViewModel)
                .environmentObject(favouriteViewModel)
                .environmentObject(profileViewModel)
            )
        }
        return AnyView(Text("Book not found"))
    }
}
