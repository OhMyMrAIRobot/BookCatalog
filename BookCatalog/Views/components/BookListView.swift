//
//  BookListView.swift
//  BookCatalog
//
//  Created by Daniil on 1.02.25.
//

import SwiftUI

struct BookListView: View{
    var books: [Book]
    var authors: [String: Author]
    var genres: [String: Genre]
    
    @EnvironmentObject var favouriteViewModel : FavouriteViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(books, id: \.id) { book in
                    if let author = authors[book.authorId],
                       let genre = genres[book.genreId] {
                        
                        NavigationLink(value: book) {
                            BookCardView(book: book, author: author, genre: genre)
                                .environmentObject(favouriteViewModel)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
}

