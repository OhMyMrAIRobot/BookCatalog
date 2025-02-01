//
//  BookViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import Foundation

class BookViewModel: ObservableObject {
    @Published var book: Book
    @Published var author: Author
    @Published var genre: Genre
    @Published var language: BookLanguage
    
    init(book: Book, author: Author, genre: Genre, language: BookLanguage) {
        self.book = book
        self.author = author
        self.genre = genre
        self.language = language
    }
}
