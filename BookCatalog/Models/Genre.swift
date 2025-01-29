//
//  Genre.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Genre {
    var id: String
    var name : String
    var description : String
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String, !id.isEmpty else { return nil }
        guard let name = data["name"] as? String, !name.isEmpty else { return nil }
        
        self.id = id
        self.name = name
        self.description = data["description"] as? String ?? ""
    }
}
