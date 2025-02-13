//
//  Author.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Author: Identifiable, Codable {
    public var id: String
    var name: String
    var surname: String = ""
    var thirdname: String = ""
}
