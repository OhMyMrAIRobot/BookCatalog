//
//  Genre.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Genre : Codable, Identifiable {
    public var id : String = UUID().uuidString
    var name : String
    var description : String
}
