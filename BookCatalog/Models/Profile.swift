//
//  Profile.swift
//  BookCatalog
//
//  Created by Daniil on 27.01.25.
//

import Foundation

public struct Profile: Identifiable, Codable {
    public var id: String
    var email: String
    var age: Int
    var name: String = ""
    var surname: String = ""
    var country: String = ""
    var about: String = ""
    var gender: String = ""
    var favBookIds: [String] = []
    var favAuthorIds: [String] = []
    var favGenreIds: [String] = []
    
    init(id: String, email: String, age: Int) {
        self.id = id
        self.email = email
        self.age = age
    }
}
