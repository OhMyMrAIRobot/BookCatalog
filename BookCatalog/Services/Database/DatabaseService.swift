//
//  DatabaseService.swift
//  BookCatalog
//
//  Created by Daniil on 27.01.25.
//

import Firebase
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    let db = Firestore.firestore()

    private init() {}

}
