//
//  CatalogService.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import FirebaseFirestore

class CatalogService {
    private let db: Firestore
    
    init(databaseService: DatabaseService) {
        self.db = databaseService.db
    }
    
    private var bookLgnsRef: CollectionReference { return db.collection("Languages") }
    private var authorsRef: CollectionReference { return db.collection("Authors") }
    private var genresRef: CollectionReference { return db.collection("Genres") }
    private var booksRef: CollectionReference { return db.collection("Books") }
    

    func getBooks() async throws -> [Book] {
        let snapshot = try await booksRef.getDocuments()
        
        let books: [Book] = snapshot.documents.compactMap { document in
            return try? document.data(as: Book.self)
        }
        books.forEach { book in
            print(book.title)
        }
        return books
    }
    
    
    func getGenres() async throws -> [String: Genre] {
        let snapshot = try await genresRef.getDocuments()
        
        var genres: [String : Genre] = [:]
        
        for document in snapshot.documents {
            if let genre = try? document.data(as: Genre.self) {
                genres[genre.id] = genre
            }
        }
        
        return genres
    }
    
    
    func getBookLanguages() async throws -> [String: BookLanguage] {
        let snapshot = try await bookLgnsRef.getDocuments()
        
        var languages: [String: BookLanguage] = [:]
        
        for document in snapshot.documents {
            if let language = try? document.data(as: BookLanguage.self) {
                languages[language.id] = language
            }
        }
        
        return languages
    }
    
    
    func getAuthorById(authorId: String) async throws -> Author {
        let document = try await authorsRef.document(authorId).getDocument()
        
        guard let data = document.data(),
              let author = try? Firestore.Decoder().decode(Author.self, from: data)
        else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Author not found"])
        }
        print(author.name)
        return author
    }
    
    
    
}
