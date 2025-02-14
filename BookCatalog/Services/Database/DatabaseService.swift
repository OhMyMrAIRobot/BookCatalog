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
    var db: Firestore

    private init() {
        let settings = FirestoreSettings()
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: 500 * 1024 * 1024 as NSNumber)
        
        db = Firestore.firestore()
        db.settings = settings
        
        if let indexManager = db.persistentCacheIndexManager {
            indexManager.enableIndexAutoCreation()
        } else {
            print("indexManager is nil")
        }
    }
}

