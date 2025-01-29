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
    var age : Int
    
    var name : String = ""
    var surname : String = ""
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
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String, !id.isEmpty else { return nil }
        guard let email = data["email"] as? String, !email.isEmpty else { return nil }
        guard let age = data["age"] as? Int else { return nil }
        
        self.id = id
        self.email = email
        self.age = age
        
        self.name = data["name"] as? String ?? ""
        self.surname = data["surname"] as? String ?? ""
        self.country = data["country"] as? String ?? ""
        self.about = data["about"] as? String ?? ""
        self.gender = data["gender"] as? String ?? ""
        
        self.favBookIds = data["favBookIds"] as? [String] ?? []
        self.favAuthorIds = data["favAuthorIds"] as? [String] ?? []
        self.favGenreIds = data["favGenreIds"] as? [String] ?? []
    }
    
    init(id: String, email: String, age: Int) {
        self.id = id
        self.email = email
        self.age = age
    }
}
