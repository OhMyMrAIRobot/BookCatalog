//
//  Book.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Book {
    var id : String
    var title : String
    var description: String
    var publishedYear : Int
    var ageRestriction: Int

    var authorId : String
    var genreId : String
    var languageId : String
    
    var images : [String]
    
    init?(data: [String : Any]) {
        guard let id = data["id"] as? String, !id.isEmpty else { return nil }
        guard let title = data["title"] as? String, !title.isEmpty else { return nil }
        guard let description = data["description"] as? String, !description.isEmpty else { return nil }
        guard let publishedYear = data["publishedYear"] as? Int else { return nil }
        guard let ageRestriction = data["ageRestriction"] as? Int else { return nil }
        guard let authorId = data["authorId"] as? String, !authorId.isEmpty else { return nil }
        guard let genreId = data["genreId"] as? String, !genreId.isEmpty else { return nil }
        guard let languageId = data["languageId"] as? String, !languageId.isEmpty else { return nil }
        
        self.id = id
        self.title = title
        self.description = description
        self.publishedYear = publishedYear
        self.ageRestriction = ageRestriction
        self.authorId = authorId
        self.genreId = genreId
        self.languageId = languageId
        self.images = data["images"] as? [String] ?? []
    }
}
