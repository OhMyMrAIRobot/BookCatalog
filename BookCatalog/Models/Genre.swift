//
//  Genre.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Genre: Identifiable, Codable {
    public var id: String
    var name : String
    var description : String
}
