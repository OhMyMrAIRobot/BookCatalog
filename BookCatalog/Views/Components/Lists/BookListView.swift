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
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    
    var body: some View {
        ScrollView {
            if !books.isEmpty {
                VStack(spacing: 20) {
                    ForEach(books, id: \.id) { book in
                        let rating = ratings[book.id] ?? 0.0
                        if let author = authors[book.authorId],
                           let genre = genres[book.genreId],
                           let language = languages[book.languageId] {
                            BookCardView(book: book, author: author, genre: genre, rating: rating, language: language)
                                .padding(.horizontal)
                        }
                    }
                }.padding(.top, 2)
            } else {
                Text("Books not found :(")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollIndicators(.hidden)
    }
}


