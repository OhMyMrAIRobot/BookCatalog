//
//  Review.swift
//  BookCatalog
//
//  Created by Daniil on 2.02.25.
//

import FirebaseFirestore


struct Review: Identifiable, Codable {
    public var id: String = UUID().uuidString
    var userId: String = "0"
    var bookId: String
    var rating: Int
    var text: String
    var date: Timestamp = Timestamp(date: .now)
    
    init(bookId: String, rating: Int, text: String) {
        self.bookId = bookId
        self.rating = rating
        self.text = text
    }
}


