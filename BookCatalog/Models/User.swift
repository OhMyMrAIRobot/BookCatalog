//
//  User.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct User : Codable {
    var name : String
    var surname : String
    var age : Int = 0
    var email : String
    var about : String
    var favBooks : [Int]
    var favAuthors : [Int]
    var favGenres : [Int]
}
