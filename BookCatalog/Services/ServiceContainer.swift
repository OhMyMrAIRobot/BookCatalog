//
//  ServiceContainer.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import Foundation

class ServiceContainer: ObservableObject {
    let databaseService: DatabaseService
    let catalogService: CatalogService
    let profileService: ProfileService
    let reviewService: ReviewService
    
    init() {
        self.databaseService = DatabaseService.shared
        self.catalogService = CatalogService(databaseService: databaseService)
        self.profileService = ProfileService(databaseService: databaseService)
        self.reviewService = ReviewService(databaseService: databaseService)
    }
}

