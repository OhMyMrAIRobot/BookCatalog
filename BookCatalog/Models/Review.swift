//
//  Review.swift
//  BookCatalog
//
//  Created by Daniil on 2.02.25.
//

import FirebaseFirestore

struct Review: Identifiable, Codable {
    public var id: String
    var userId: String
    var bookId: String
    var rating: Int
    var text: String
    var date: Timestamp
}
