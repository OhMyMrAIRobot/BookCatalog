//
//  BookFilterSheetView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import SwiftUI

struct BookFilterSheetView: View {
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
    
    let years = Array(1500...Calendar.current.component(.year, from: Date()))
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Genres")) {
                    NavigationLink("Select Genres",
                        destination: MultiSelectListView(items: catalogViewModel.genres.keys.sorted(),
                                                            selectedItems: $selectedGenres,
                                                         itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" })
                    )
                }
                
                Section(header: Text("Languages")) {
                    NavigationLink("Select Languages", destination: MultiSelectListView(items: catalogViewModel.languages.keys.sorted(), selectedItems: $selectedLanguages, itemNameProvider: { catalogViewModel.languages[$0]?.name ?? "" }))
                }
                
                Section(header: Text("Age Range")) {
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
                
                
                Section(header: Text("Publication Year Range")) {
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
                
                
                Section(header: Text("Sort By")) {
                    NavigationLink(destination: SortSelectionView(selectedSortOption: $selectedSortOption)) {
                        HStack {
                            Text("Selected: \(selectedSortOption.rawValue)")
                            Spacer()

                        }
                    }
                }
                
            }
            .navigationTitle("Filter & sort books")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        isPresented = false
                        catalogViewModel.filterBooks(bookRatings: ratingViewModel.bookRatings)
                    }
                }
            }
        }
    }
}


struct MultiSelectListView: View {
    let items: [String]
    @Binding var selectedItems: Set<String>
    let itemNameProvider: (String) -> String
    
    var body: some View {
        List(items, id: \..self) { item in
            HStack {
                Text(itemNameProvider(item))
                Spacer()
                if selectedItems.contains(item) {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if selectedItems.contains(item) {
                    selectedItems.remove(item)
                } else {
                    selectedItems.insert(item)
                }
            }
        }
        .navigationTitle("Select Items")
    }
}


struct SortSelectionView: View {
    @Binding var selectedSortOption: CatalogViewModel.SortOption
    
    var body: some View {
        List {
            ForEach(CatalogViewModel.SortOption.allCases, id: \..self) { option in
                Button {
                    selectedSortOption = option
                } label: {
                    HStack {
                        Text(option.rawValue)
                            .fontWeight(selectedSortOption == option ? .semibold : .regular)
                        Spacer()
                        if selectedSortOption == option {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .foregroundColor(.black)
            }
        }
        .navigationTitle("Sort Books")
    }
}
