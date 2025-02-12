//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var authService = AuthService.shared
    
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
    @State var isDataLoaded = false
    @State var isLoading = true
    
    var body: some View {
        VStack(spacing: 20) {
            SearchBarView(searchText: $catalogViewModel.searchText)
                .frame(maxHeight: 60)
            
            if !isLoading {
                BookListView(
                    books: catalogViewModel.isFilterActive() || !catalogViewModel.searchText.isEmpty ? catalogViewModel.filteredBooks : catalogViewModel.books,
                    authors: catalogViewModel.authors,
                    genres: catalogViewModel.genres,
                    ratings: ratingViewModel.bookRatings,
                    languages: catalogViewModel.languages
                )
                .padding(.top, 15)
                .background(.white.opacity(0.9))
            } else {
                CustomProgressView(text: "Loading books...")
            }
        }
        .onAppear {
            Task {
                if !isDataLoaded {
                    await catalogViewModel.fetchData()
                    await ratingViewModel.fetchBookRatings(books: catalogViewModel.books)
                    await favouriteViewModel.fetchFavouriteBookIds()
                    await MainActor.run {
                        isDataLoaded = true
                        isLoading = false
                    }
                }
            }
        }
        .refreshable {
            await catalogViewModel.fetchData()
            await ratingViewModel.fetchBookRatings(books: catalogViewModel.books)
            await favouriteViewModel.fetchFavouriteBookIds()
        }
    }
}

