//
//  Author.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import Foundation

public struct Author {
    var id : String = "123"
    var name : String = "Suzy"
    var surname : String = "Menkes"
    var thirdname : String = ""
    
    init () {
        
    }
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String, !id.isEmpty else { return nil }
        guard let name = data["name"] as? String, !name.isEmpty else { return nil }
        guard let surname = data["surname"] as? String, !surname.isEmpty else { return nil }
        
        self.id = id
        self.name = name
        self.surname = surname
        self.thirdname = data["thirdname"] as? String ?? ""
    }
}
