//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var favouriteViewModel : FavouriteViewModel
    @StateObject var mainViewModel = MainViewModel()
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
                
                SearchBarView(searchText: $mainViewModel.searchText)
                    .padding(.bottom, 20)
                
                
//                ScrollView {
//                    VStack(spacing: 20) {
//                        ForEach(mainViewModel.filteredBooks.isEmpty ? mainViewModel.books : mainViewModel.filteredBooks, id: \.id) { book in
//                            if let author = mainViewModel.authors[book.authorId],
//                               let genre = mainViewModel.genres[book.genreId] {
//                                
//                                NavigationLink(value: book) {
//                                    BookCardView(book: book, author: author, genre: genre)
//                                        .environmentObject(favouriteViewModel)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal)
//                .scrollIndicators(.hidden)
                BookListView(
                    books: mainViewModel.filteredBooks.isEmpty ? mainViewModel.books : mainViewModel.filteredBooks,
                    authors: mainViewModel.authors,
                    genres: mainViewModel.genres
                )
                .environmentObject(favouriteViewModel)
                
            }
            .background(Color(.systemGray6))
            .navigationDestination(for: Book.self) { book in
                if let author = mainViewModel.authors[book.authorId],
                   let genre = mainViewModel.genres[book.genreId] {
                    
                    BookView(bookViewModel: BookViewModel(
                        book: book,
                        author: author,
                        genre: genre,
                        language: BookLanguage()
                    ))
                    .environmentObject(favouriteViewModel)
                }
            }
        }
        .onAppear {
            mainViewModel.fetchBooks()
            mainViewModel.fetchGenres()
        }
    }
}

//#Preview {
//    MainView()
//}

