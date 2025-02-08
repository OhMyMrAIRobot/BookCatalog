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
    
    var body : some View {
        VStack {
            Text("Favourite books")
                .font(.system(size: 32))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            BookListView(
                books: catalogViewModel.books.filter { favouriteViewModel.favouriteBookIds.contains($0.id) },
                authors: catalogViewModel.authors,
                genres: catalogViewModel.genres,
                ratings: ratingViewModel.bookRatings
            )
            .background(Color(.systemGray6))
        }
        .refreshable {
            await favouriteViewModel.fetchFavouriteBookIds()
        }
    }
}


