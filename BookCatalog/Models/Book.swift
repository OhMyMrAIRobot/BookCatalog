//
//  Book.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Book: Identifiable, Codable, Hashable {
    public var id: String
    var title: String
    var description: String
    var publishedYear: Int
    var ageRestriction: Int
    var authorId: String
    var genreId: String
    var languageId: String
    var images: [String]
}

