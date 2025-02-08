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
        NavigationStack {
            
            List {
                Section(header: Text("Genres")) {
                    NavigationLink("Select genres",
                                   destination: MultiSelectListView(title: "Select Genres",
                                                                    items: catalogViewModel.genres.keys.sorted {
                                                                        (catalogViewModel.genres[$0]?.name ?? "") < (catalogViewModel.genres[$1]?.name ?? "")
                                                                    },
                                                                    selectedItems: $selectedGenres,
                                                                    itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" })
                    )
                }
                
                Section(header: Text("Languages")) {
                    NavigationLink("Select languages", destination: MultiSelectListView(title: "Select languages",
                                                                                        items: catalogViewModel.languages.keys.sorted {
                        (catalogViewModel.languages[$0]?.name ?? "") < (catalogViewModel.languages[$1]?.name ?? "")
                                                                                        },
                                                                                        selectedItems: $selectedLanguages, itemNameProvider: {
                                                                                        catalogViewModel.languages[$0]?.name ?? "" })
                    )
                }
                
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
                                    .foregroundColor(.black)
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
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                
                Section(header: Text("Sort by")) {
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
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        isPresented = false
                        catalogViewModel.filterBooks(bookRatings: ratingViewModel.bookRatings)
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}


struct SortSelectionView: View {
    @Binding var selectedSortOption: CatalogViewModel.SortOption
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ForEach(CatalogViewModel.SortOption.allCases, id: \..self) { option in
                Button {
                    selectedSortOption = option
                    dismiss()
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
        .navigationTitle("Choose the sort type")
    }
}
