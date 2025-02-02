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
    
    
    func fetchBooks() async {
        do {
            let books = try await DatabaseService.shared.getBooks()
            await MainActor.run {
                self.books = books
            }
            await fetchAuthors()
        } catch {
            print("Failed to fetch books: \(error.localizedDescription)")
        }
    }
    
    
    func fetchAuthors() async {
        for book in books {
            do {
                let author = try await DatabaseService.shared.getAuthorById(authorId: book.authorId)
                await MainActor.run {
                    self.authors[author.id] = author
                }
            } catch {
                print("Failed to fetch author: \(error.localizedDescription)")
            }
        }
    }
    
    
    func fetchGenres() async {
        do {
            let genres = try await DatabaseService.shared.getGenres()
            await MainActor.run {
                self.genres = genres
            }
        } catch {
            print("Failed to fetch genres: \(error.localizedDescription)")
        }
    }
    
    
    func fetchLanguages() async {
        do {
            let languages = try await DatabaseService.shared.getBookLanguages()
            await MainActor.run {
                self.languages = languages
            }
        } catch {
            print("Failed to fetch languages: \(error.localizedDescription)")
        }
    }
    
    
    func searchBooks(byTitle query: String, in books: [Book]) -> [Book] {
        return books.filter { $0.title.lowercased().contains(query.lowercased()) }
    }

}
