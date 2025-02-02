//
//  FavouriteViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 1.02.25.
//

import Foundation

class FavouriteViewModel : ObservableObject {
    @Published var favouriteBookIds : [String] = []
    
    func toggleFavouriteBook(bookId: String) async {
        do {
            let isSuccess = try await DatabaseService.shared.toggleFavouriteBook(bookId: bookId)
            
            if isSuccess {
                await MainActor.run {
                    if favouriteBookIds.contains(bookId) {
                        favouriteBookIds.removeAll { $0 == bookId }
                    } else {
                        favouriteBookIds.append(bookId)
                    }
                }
            }
        } catch {
            print("Failed toggle favourite book: \(error.localizedDescription)")
        }
    }
    
    
    func fetchFavouriteBookIds() async {
        do {
            let favouriteBookIds = try await DatabaseService.shared.getFavouriteBookIds()
            await MainActor.run {
                self.favouriteBookIds = favouriteBookIds
            }
        } catch {
            print("Failed to fetch favourite book ids: \(error.localizedDescription)")
        }
    }
}
