//
//  MainViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import Foundation

class CatalogViewModel : ObservableObject {
    private var catalogService: CatalogService
    
    init(container: ServiceContainer) {
        self.catalogService = container.catalogService
    }
    
    @Published var books : [Book] = []
    @Published var authors : [String : Author] = [:]
    @Published var genres : [String: Genre] = [:]
    @Published var languages: [String: BookLanguage] = [:]
    @Published var filteredBooks : [Book] = []
    
    @Published var selectedGenres: Set<String> = []
    @Published var selectedLanguages: Set<String> = []
    @Published var selectedSortOption: SortOption = .none
    @Published var minYearFilter: Int = 1500
    @Published var maxYearFilter: Int = Calendar.current.component(.year, from: Date())
    @Published var minAgeFilter = 0
    @Published var maxAgeFilter = 18
    
    @Published var searchText = ""
    
    enum SortOption: String, CaseIterable {
        case none = "None"
        case ratingDescending = "Rating (High to Low)"
        case ratingAscending = "Rating (Low to High)"
        case releaseDateDescending = "Publish year (Newest first)"
        case releaseDateAscending = "Publish year (Oldest first)"
        case ageDescending = "Age restriction (High to Low)"
        case ageAscending = "Age restriction (Low to High)"
    }
    
    @MainActor
    func fetchBooks() async {
        do {
            let books = try await catalogService.getBooks()
            self.books = books
        } catch {
            print("Failed to fetch books: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchAuthors() async {
//        for book in books {
//            do {
//                let author = try await catalogService.getAuthorById(authorId: book.authorId)
//                authors[author.id] = author
//            } catch {
//                print("Failed to fetch author: \(error.localizedDescription)")
//            }
//        }
        do {
            let authors = try await catalogService.getAuthors()
            self.authors = authors
        } catch {
            print("Failed to fetch authors: \(error.localizedDescription)")
        }

    }
    
    @MainActor
    func fetchGenres() async {
        do {
            let genres = try await catalogService.getGenres()
            self.genres = genres
        } catch {
            print("Failed to fetch genres: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchLanguages() async {
        do {
            let languages = try await catalogService.getBookLanguages()
            self.languages = languages
        } catch {
            print("Failed to fetch languages: \(error.localizedDescription)")
        }
    }

    @MainActor
    func fetchData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.fetchBooks()
            }
            group.addTask {
                await self.fetchAuthors()
            }
            group.addTask {
                await self.fetchGenres()
            }
            group.addTask {
                await self.fetchLanguages()
            }
        }
    }
    
    func filterBooks(bookRatings: [String: Double]) {
        filteredBooks = books.filter { book in
            let matchesGenre = selectedGenres.isEmpty || selectedGenres.contains(book.genreId)
            let matchesLanguage = selectedLanguages.isEmpty || selectedLanguages.contains(book.languageId)
            let matchesSearch = searchText.isEmpty || book.title.lowercased().contains(searchText.lowercased())
            let matchesYear = (book.publishedYear < maxYearFilter) && (book.publishedYear > minYearFilter)
            let matchesAge = (book.ageRestriction < maxYearFilter) && (book.ageRestriction > minAgeFilter)
            
            return matchesSearch && matchesGenre && matchesLanguage && matchesYear && matchesAge
        }
        
        switch selectedSortOption {
        case .none: break
        case .ratingDescending:
            filteredBooks.sort { (bookRatings[$0.id] ?? 0) > (bookRatings[$1.id] ?? 0) }
        case .ratingAscending:
            filteredBooks.sort { (bookRatings[$0.id] ?? 0) < (bookRatings[$1.id] ?? 0) }
        case .releaseDateDescending:
            filteredBooks.sort { $0.publishedYear > $1.publishedYear }
        case .releaseDateAscending:
            filteredBooks.sort { $0.publishedYear < $1.publishedYear }
        case .ageDescending:
            filteredBooks.sort { $0.ageRestriction > $1.ageRestriction }
        case .ageAscending:
            filteredBooks.sort { $0.ageRestriction < $1.ageRestriction }
        }
    }
    
    func isFilterActive() -> Bool {
        return !(selectedGenres.isEmpty &&
        selectedLanguages.isEmpty &&
        selectedSortOption == .none &&
        minYearFilter == 1500 &&
        maxYearFilter == Calendar.current.component(.year, from: Date()) &&
        minAgeFilter == 0 &&
        maxAgeFilter == 18)
    }
}
