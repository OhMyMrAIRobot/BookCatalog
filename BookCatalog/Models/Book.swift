//
//  Book.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Book {
    var id : String = "123"
    var title : String = "Yves Saint Laurent"
    var description: String = "desc"
    var publishedYear : Int = 2024
    var ageRestriction: Int = 6
    
    var authorId : String = "13243"
    var genreId : String = "342234"
    var languageId : String = "32424"
    
    var images : [String] = ["https://www.sostav.ru/images/news/2022/04/08/d5bazwrc.png"]
    init () {
        
    }
    
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
