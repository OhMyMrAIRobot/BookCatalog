//
//  MainViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import Foundation

class CatalogViewModel : ObservableObject {
    @Published var books : [Book] = []
    @Published var authors : [String : Author] = [:]
    @Published var genres : [String: Genre] = [:]
    @Published var languages: [String: BookLanguage] = [:]
    @Published var filteredBooks : [Book] = []

    
    @Published var searchText = "" {
        didSet {
            filteredBooks = searchBooks(byTitle: searchText, in: books)
        }
    }
    
    @MainActor
    func fetchBooks() async {
        do {
            let books = try await DatabaseService.shared.getBooks()
            self.books = books
        } catch {
            print("Failed to fetch books: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchAuthors() async {
        for book in books {
            do {
                let author = try await DatabaseService.shared.getAuthorById(authorId: book.authorId)
                authors[author.id] = author
            } catch {
                print("Failed to fetch author: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func fetchGenres() async {
        do {
            let genres = try await DatabaseService.shared.getGenres()
            self.genres = genres
        } catch {
            print("Failed to fetch genres: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchLanguages() async {
        do {
            let languages = try await DatabaseService.shared.getBookLanguages()
            self.languages = languages
        } catch {
            print("Failed to fetch languages: \(error.localizedDescription)")
        }
    }

    
    func searchBooks(byTitle query: String, in books: [Book]) -> [Book] {
        return books.filter { $0.title.lowercased().contains(query.lowercased()) }
    }

}
