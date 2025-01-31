//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var mainViewModel = MainViewModel()

    var body: some View {
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
            
            ScrollView() {
                VStack(spacing: 20) {
                    if (!mainViewModel.filteredBooks.isEmpty) {
                        
                        ForEach(0..<mainViewModel.filteredBooks.count, id: \.self) { idx in
                            let book = mainViewModel.filteredBooks[idx]
                            let author = mainViewModel.authors[book.authorId]
                            let genre = mainViewModel.genres[book.genreId]
                            
                            BookCardView(book: book, author: author ?? Author(), genre: genre ?? Genre())
                        }
                    } else {
                        ForEach(0..<mainViewModel.books.count, id: \.self) { idx in
                            let book = mainViewModel.books[idx]
                            let author = mainViewModel.authors[book.authorId]
                            let genre = mainViewModel.genres[book.genreId]
                            
                            BookCardView(book: book, author: author ?? Author(), genre: genre ?? Genre())
                        }
                    }

                }.padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            mainViewModel.fetchBooks()
            mainViewModel.fetchGenres()
        }
    }
}

#Preview {
    MainView()
}
