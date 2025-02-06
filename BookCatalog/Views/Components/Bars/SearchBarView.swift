//
//  SearchBarView.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import SwiftUI

struct SearchBarView : View {
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
    @Binding var searchText: String
    @State private var isFilterSheetPresented: Bool = false
    
    var body : some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search books here...", text: $searchText)
                .autocorrectionDisabled(true)
                .accentColor(.black)
                .onChange(of: searchText) {
                    catalogViewModel.filterBooks(bookRatings: ratingViewModel.bookRatings)
                }
            
            Button(action: {
                isFilterSheetPresented.toggle()
            }) {
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title)
                    .background(.white)
                    .foregroundColor(catalogViewModel.selectedGenres.isEmpty &&
                                     catalogViewModel.selectedLanguages.isEmpty  ?
                        .gray : .black)
            }
            .padding(.trailing, 10)
            .sheet(isPresented: $isFilterSheetPresented) {
                BookFilterSheetView(
                    isPresented: $isFilterSheetPresented,
                    selectedGenres: $catalogViewModel.selectedGenres,
                    selectedLanguages: $catalogViewModel.selectedLanguages,
                    selectedSortOption: $catalogViewModel.selectedSortOption,
                    minAge: $catalogViewModel.minAgeFilter,
                    maxAge: $catalogViewModel.maxAgeFilter,
                    minYear: $catalogViewModel.minYearFilter,
                    maxYear: $catalogViewModel.maxYearFilter
                )
                    .presentationDragIndicator(.visible)
            }
        }
        .padding(15)
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

//#Preview {
//    @State var text: String = ""
//    SearchBarView(searchText: $text)
//}
