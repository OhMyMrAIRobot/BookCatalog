//
//  Profile.swift
//  BookCatalog
//
//  Created by Daniil on 27.01.25.
//

import Foundation

public struct Profile {
    var id : String
    var email : String
    var name : String = ""
    var surname : String = ""
    var age : Int
    var country : String = ""
    var about : String = ""
    var gender : String = ""
    var favBookIds : [String] = []
    var favAuthorIds : [String] = []
    var favGenreIds : [String] = []
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        
        repres["id"] = self.id
        repres["email"] = self.email
        repres["name"] = self.name
        repres["surname"] = self.surname
        repres["age"] = self.age
        repres["country"] = self.country
        repres["about"] = self.about
        repres["gender"] = self.gender
        repres["favBookIds"] = self.favBookIds
        repres["favAuthorIds"] = self.favAuthorIds
        repres["favGenreIds"] = self.favGenreIds
        
        return repres
    }
}
