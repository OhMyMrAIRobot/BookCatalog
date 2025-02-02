//
//  FavouriteView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

struct FavouriteView : View {
    
    @State var navigationPath = NavigationPath()
    @EnvironmentObject var favouriteViewModel : FavouriteViewModel
    @EnvironmentObject var catalogViewModel : CatalogViewModel
    
    var body : some View {
        NavigationStack(path: $navigationPath) {
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
                    genres: catalogViewModel.genres
                )
                .environmentObject(favouriteViewModel)
                .background(Color(.systemGray6))
                .navigationDestination(for: Book.self) { book in
                    if let author = catalogViewModel.authors[book.authorId],
                       let genre = catalogViewModel.genres[book.genreId] {
                        
                        BookView(bookViewModel: BookViewModel(
                            book: book,
                            author: author,
                            genre: genre,
                            language: BookLanguage()
                        ))
                        .environmentObject(favouriteViewModel)
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }
}

//#Preview {
//    FavouriteView()
//        .environmentObject(FavouriteViewModel())
//        .environmentObject(CatalogViewModel())
//}
