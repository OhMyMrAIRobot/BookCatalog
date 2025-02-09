//
//  FavouriteViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 1.02.25.
//

import Foundation

class FavouriteViewModel : ObservableObject {
    private let profileService: ProfileService
    
    @Published var favouriteBookIds : [String] = []
    
    init(container: ServiceContainer) {
        self.profileService = container.profileService
    }
    
    @MainActor
    func toggleFavouriteBook(bookId: String) async {
        do {
            let isSuccess = try await profileService.toggleFavouriteBook(bookId: bookId)
            
            if isSuccess {
                if favouriteBookIds.contains(bookId) {
                    favouriteBookIds.removeAll { $0 == bookId }
                } else {
                    favouriteBookIds.append(bookId)
                }
            }
        } catch {
            print("Failed toggle favourite book: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchFavouriteBookIds() async {
        do {
            let favouriteBookIds = try await profileService.getFavouriteBookIds()
            self.favouriteBookIds = favouriteBookIds
        } catch {
            print("Failed to fetch favourite book ids: \(error.localizedDescription)")
        }
    }
}
