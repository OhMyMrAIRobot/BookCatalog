//
//  Book.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Book : Codable, Identifiable {
    public var id : String = UUID().uuidString
    var title : String
    var publishedYear : Int
    var pageCount: Int

    var authorId : String
    var genreId : String
    var languageId : String
    
    var images : [String]
}
