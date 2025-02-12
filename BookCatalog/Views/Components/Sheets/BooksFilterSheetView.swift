//
//  BooksFilterSheetView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import SwiftUI

struct BooksFilterSheetView: View {
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
    @Binding var isPresented: Bool
    @Binding var selectedGenres: Set<String>
    @Binding var selectedLanguages: Set<String>
    @Binding var selectedSortOption: CatalogViewModel.SortOption
    @Binding var minAge: Int
    @Binding var maxAge: Int
    @Binding var minYear: Int
    @Binding var maxYear: Int
    
    @State private var isGenresPresented = false
    @State private var isLanguagesPresented = false
    @State private var isSortPresented = false
    
    let years = Array(1500...Calendar.current.component(.year, from: Date()))
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    SectionButtonView(header: "Genres", text: "Select genres") { isGenresPresented = true }
                    SectionButtonView(header: "Languages", text: "Select languages") { isLanguagesPresented = true }
                    
                    Section(header: Text("Age restriction range")) {
                        HStack {
                            Text("Min Age: \(minAge)")
                            Spacer()
                            Stepper("", value: $minAge, in: 0...maxAge)
                        }
                        HStack {
                            Text("Max Age: \(maxAge)")
                            Spacer()
                            Stepper("", value: $maxAge, in: minAge...18)
                        }
                    }
                    
                    Section(header: Text("Publication year range")) {
                        HStack {
                            Text("From")
                            Spacer()
                            Picker("", selection: $minYear) {
                                ForEach(years, id: \.self) { year in
                                    Text("\(year)").tag(year)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        HStack {
                            Text("To")
                            Spacer()
                            Picker("", selection: $maxYear) {
                                ForEach(years, id: \.self) { year in
                                    Text("\(year)").tag(year)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                    
                    SectionButtonView(header: "Sort by", text: "Selected: \(selectedSortOption.rawValue)") { isSortPresented = true }
                }
                .navigationTitle("Filter & Sort")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresented = false
                        }
                        .foregroundStyle(Color.black)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Apply") {
                            isPresented = false
                            catalogViewModel.filterBooks(bookRatings: ratingViewModel.bookRatings)
                        }
                        .foregroundStyle(Color.black)
                    }
                }
            }
            .background(Color.white.opacity(0.9))
            .scrollContentBackground(.hidden)
            
            .navigationDestination(isPresented: $isGenresPresented) {
                MultiSelectListView(
                    title: "Select Genres",
                    items: catalogViewModel.genres.keys.sorted {
                        (catalogViewModel.genres[$0]?.name ?? "") < (catalogViewModel.genres[$1]?.name ?? "")
                    },
                    selectedItems: $selectedGenres,
                    itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" }
                )
            }
            
            .navigationDestination(isPresented: $isLanguagesPresented) {
                MultiSelectListView(
                    title: "Select Languages",
                    items: catalogViewModel.languages.keys.sorted {
                        (catalogViewModel.languages[$0]?.name ?? "") < (catalogViewModel.languages[$1]?.name ?? "")
                    },
                    selectedItems: $selectedLanguages,
                    itemNameProvider: { catalogViewModel.languages[$0]?.name ?? "" }
                )
            }
            
            .navigationDestination(isPresented: $isSortPresented) {
                SingleSelectListView(
                    title: "Choose the sort type",
                    items: CatalogViewModel.SortOption.allCases.map { $0.rawValue },
                    selectedItem: Binding(
                        get: { selectedSortOption.rawValue },
                        set: { newValue in
                            if let newOption = CatalogViewModel.SortOption(rawValue: newValue ?? "Unknown") {
                                selectedSortOption = newOption
                            }
                        }
                    ),
                    itemNameProvider: { $0 }
                )
            }
        }
    }
}

struct SectionButtonView: View {
    let header: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Section(header: Text(header)) {
            Button(action: action) {
                HStack {
                    Text(text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
            }.foregroundStyle(.black)
        }
    }
}
