//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var authService = AuthService.shared
    
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Book list")
                    .font(.system(size: 32))
                    .fontDesign(.rounded) // TODO: найти норм шрифт
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SearchBarView(searchText: $catalogViewModel.searchText)
                    .padding(.bottom, 20)
                
                BookListView(
                    books: catalogViewModel.filteredBooks.isEmpty ? catalogViewModel.books : catalogViewModel.filteredBooks,
                    authors: catalogViewModel.authors,
                    genres: catalogViewModel.genres,
                    ratings: ratingViewModel.bookRatings
                )
                
            }
            .background(Color(.systemGray6))
            .navigationDestination(for: Book.self) { book in
                if let author = catalogViewModel.authors[book.authorId],
                   let genre = catalogViewModel.genres[book.genreId],
                   let language = catalogViewModel.languages[book.languageId],
                   let rating = ratingViewModel.bookRatings[book.id] {
                    BookView(bookViewModel: BookViewModel(
                        book: book,
                        author: author,
                        genre: genre,
                        language: language,
                        rating: rating
                    ))
                    .environmentObject(ratingViewModel)
                    .environmentObject(favouriteViewModel)
                    .environmentObject(profileViewModel)
                }
            }
        }
        .onAppear {
            Task {
                print("appear")
                await catalogViewModel.fetchBooks()
                await catalogViewModel.fetchAuthors()
                await catalogViewModel.fetchGenres()
                await catalogViewModel.fetchLanguages()
                await ratingViewModel.fetchBookRatings(books: catalogViewModel.books)
            }
        }
    }
}

//#Preview {
//    MainView()
//}

