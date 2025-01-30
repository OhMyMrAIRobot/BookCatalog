//
//  Genre.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Genre {
    var id: String = "123"
    var name : String = "Fantasy"
    var description : String = "Something ..."
    
    init() {
        
    }
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String, !id.isEmpty else { return nil }
        guard let name = data["name"] as? String, !name.isEmpty else { return nil }
        
        self.id = id
        self.name = name
        self.description = data["description"] as? String ?? ""
    }
}
