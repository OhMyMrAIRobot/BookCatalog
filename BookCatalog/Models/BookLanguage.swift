//
//  BookLanguage.swift
//  BookCatalog
//
//  Created by Daniil on 28.01.25.
//

import Foundation

public struct BookLanguage {
    var id : String
    var name : String
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String, !id.isEmpty else { return nil }
        guard let name = data["name"] as? String, !name.isEmpty else { return nil }
        
        self.id = id
        self.name = name
    }
}
