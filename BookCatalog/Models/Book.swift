//
//  Book.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Book: Identifiable, Hashable {
    public var id : String = UUID().uuidString
    var title : String = "Some book title"
    var description: String = "A journey through the otherworldly science behind Christopher Nolan’s award-winning film, Interstellar, from executive producer and Nobel Prize-winning physicist Kip Thorne. Interstellar, from acclaimed filmmaker Christopher Nolan, takes us on a fantastic voyage far beyond our solar system. Yet in The Science of Interstellar, Kip Thorne, the Nobel prize-winning physicist who assisted Nolan on the scientific aspects of Interstellar, shows us that the movie’s jaw-dropping events and stunning, never-before-attempted visuals are grounded in real science. Thorne shares his experiences working as the science adviser on the film and then moves on to the science itself. In chapters on wormholes, black holes, interstellar travel, and much more, Thorne’s scientific insights ― many of them triggered during the actual scripting and shooting of Interstellar ― describe the physical laws that govern our universe and the truly astounding phenomena that those laws make possible."
    var publishedYear : Int = 2024
    var ageRestriction: Int = 5
    
    var authorId : String = "13243"
    var genreId : String = "342234"
    var languageId : String = "32424"
    
    var images : [String] = [
        "https://www.sostav.ru/images/news/2022/04/08/d5bazwrc.png",
        "https://storage.fabulae.ru/images/authors/10538/foto_96852.jpg",
        "https://i.pinimg.com/736x/29/e9/0f/29e90fbcac66748657516eb12f85832c.jpg"
    ]
    
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
