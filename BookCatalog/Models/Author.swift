//
//  Author.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Author : Codable, Identifiable {
    public var id : String = UUID().uuidString
    var name : String
    var surname : String
    var thirdname : String
}
