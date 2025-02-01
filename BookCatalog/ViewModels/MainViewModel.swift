//
//  MainViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import Foundation

class MainViewModel : ObservableObject {
    
    @Published var books : [Book] = []
    @Published var authors : [String : Author] = [:]
    @Published var genres : [String: Genre] = [:]
    @Published var filteredBooks : [Book] = []
    @Published var favouriteBookIds : [String] = []
    
    @Published var searchText = "" {
        didSet {
            filteredBooks = searchBooks(byTitle: searchText, in: books)
        }
    }
    
    func fetchBooks() {
        DatabaseService.shared.getBooks { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.books = books
                    self.fetchAuthors()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func fetchAuthors() {
        books.forEach { book in
            DatabaseService.shared.getAuthorById(authorId: book.authorId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let author):
                            self.authors[author.id] = author
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchGenres() {
        DatabaseService.shared.getGenres { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let genres):
                    self.genres = genres
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func searchBooks(byTitle query: String, in books: [Book]) -> [Book] {
        return books.filter { $0.title.lowercased().contains(query.lowercased()) }
    }
    
    
    func toggleFavouriteBook(bookId: String) {
        DatabaseService.shared.toggleFavouriteBook(bookId: bookId) { result in
            if result {
                if self.favouriteBookIds.contains(bookId) {
                    self.favouriteBookIds.removeAll { $0 == bookId }
                } else {
                    self.favouriteBookIds.append(bookId)
                }
            }
        }
    }
    
    
    func fetchFavouriteBookIds() {
        DatabaseService.shared.getFavouriteBookIds { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bookIds):
                    self.favouriteBookIds = bookIds
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
