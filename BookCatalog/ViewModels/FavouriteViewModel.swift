//
//  FavouriteViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 1.02.25.
//

import Foundation

class FavouriteViewModel : ObservableObject {
    @Published var favouriteBookIds : [String] = []
    
    func toggleFavouriteBook(bookId: String) {
        DatabaseService.shared.toggleFavouriteBook(bookId: bookId) { result in
            if result {
                if self.favouriteBookIds.contains(bookId) {
                    self.favouriteBookIds.removeAll { $0 == bookId }
                } else {
                    self.favouriteBookIds.append(bookId)
                }
            }
        }
    }
    
    
    func fetchFavouriteBookIds() {
        DatabaseService.shared.getFavouriteBookIds { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bookIds):
                    self.favouriteBookIds = bookIds
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
