//
//  FavouriteView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

struct FavouriteView : View {
    @ObservedObject var authService = AuthService.shared
    
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Favourite books")
                .font(.system(size: 36))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxHeight: 60)
            
                BookListView(
                    books: catalogViewModel.books.filter { favouriteViewModel.favouriteBookIds.contains($0.id) },
                    authors: catalogViewModel.authors,
                    genres: catalogViewModel.genres,
                    ratings: ratingViewModel.bookRatings,
                    languages: catalogViewModel.languages
                )
                .padding(.top, 15)
                .background(.white.opacity(0.9))
        }
        .refreshable {
            await favouriteViewModel.fetchFavouriteBookIds()
        }
    }
}


