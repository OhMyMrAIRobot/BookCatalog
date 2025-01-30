//
//  MainViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import Foundation

class MainViewModel : ObservableObject {
    
    @Published var books : [String: Book] = [:]
    @Published var authors : [String : Author] = [:]

    
    func fetchBooks() {
        DatabaseService.shared.getBooks { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.books = books
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func fetchAuthors() {
        books.forEach { (bookId, book) in
            DatabaseService.shared.getAuthorById(authorId: book.authorId) { result in
                switch result {
                case .success(let author):
                    DispatchQueue.main.async {
                        self.authors[author.id] = author
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
