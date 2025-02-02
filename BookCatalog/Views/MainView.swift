//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    @EnvironmentObject var catalogViewModel : CatalogViewModel
    @State private var navigationPath = NavigationPath()
    
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
                    genres: catalogViewModel.genres
                )
                .environmentObject(favouriteViewModel)
                
            }
            .background(Color(.systemGray6))
            .navigationDestination(for: Book.self) { book in
                if let author = catalogViewModel.authors[book.authorId],
                   let genre = catalogViewModel.genres[book.genreId],
                   let language = catalogViewModel.languages[book.languageId] {
                    BookView(bookViewModel: BookViewModel(
                        book: book,
                        author: author,
                        genre: genre,
                        language: language
                    ))
                    .environmentObject(favouriteViewModel)
                }
            }
        }
        .onAppear {
            Task {
                await catalogViewModel.fetchBooks()
                await catalogViewModel.fetchGenres()
                await catalogViewModel.fetchLanguages()
            }
        }
    }
}

//#Preview {
//    MainView()
//}

