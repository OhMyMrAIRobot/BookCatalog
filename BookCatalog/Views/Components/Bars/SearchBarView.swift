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
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.gradientGray : Color.gradientColor)
            
            TextField("Search books here...", text: $searchText)
                .autocorrectionDisabled(true)
                .accentColor(.purple)
                .onChange(of: searchText) {
                    catalogViewModel.filterBooks(bookRatings: ratingViewModel.bookRatings)
                }
            
            Button(action: {
                isFilterSheetPresented.toggle()
            }) {
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title)
                    .background(.white)
                    .foregroundStyle(catalogViewModel.isFilterActive() ? Color.gradientColor : Color.gradientGray)
            }
            .padding(.trailing, 10)
        }
        .padding(15)
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal)
        
        .sheet(isPresented: $isFilterSheetPresented) {
            BooksFilterSheetView(
                isPresented: $isFilterSheetPresented,
                selectedGenres: $catalogViewModel.selectedGenres,
                selectedLanguages: $catalogViewModel.selectedLanguages,
                selectedSortOption: $catalogViewModel.selectedSortOption,
                minAge: $catalogViewModel.minAgeFilter,
                maxAge: $catalogViewModel.maxAgeFilter,
                minYear: $catalogViewModel.minYearFilter,
                maxYear: $catalogViewModel.maxYearFilter
            )
            .presentationBackground(Color.gradientColor)
            .presentationDragIndicator(.visible)
        }
    }
}

