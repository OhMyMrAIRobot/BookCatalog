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
    var ratings: [String: Double]
    var languages: [String: BookLanguage]
    
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    
    var body: some View {
        ScrollView {
            if !books.isEmpty {
                VStack(spacing: 20) {
                    ForEach(books, id: \.id) { book in
                        if let author = authors[book.authorId],
                           let genre = genres[book.genreId],
                           let rating = ratings[book.id],
                           let language = languages[book.languageId] {
                            
                            BookCardView(book: book, author: author, genre: genre, rating: rating, language: language)
                                .padding(.horizontal)
                        }
                    }
                }
            } else {
                Text("Books not found :(")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollIndicators(.hidden)
    }
}


