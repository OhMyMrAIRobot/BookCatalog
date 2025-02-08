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
        VStack {
            if !isLoading {
                Text("Book list")
                    .font(.system(size: 32))
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SearchBarView(searchText: $catalogViewModel.searchText)
                
                BookListView(
                    books: catalogViewModel.filteredBooks.isEmpty ? catalogViewModel.books : catalogViewModel.filteredBooks,
                    authors: catalogViewModel.authors,
                    genres: catalogViewModel.genres,
                    ratings: ratingViewModel.bookRatings
                )
                .padding(.top, 20)
                    
                
            } else {
                ProgressView("Loading books...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color(.systemGray6))
        .onAppear {
            Task {
                if !isDataLoaded {
                    print("fetch")
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


//#Preview {
//    MainView()
//}

