//
//  ReviewFilterSheetView.swift
//  BookCatalog
//
//  Created by Daniil on 5.02.25.
//

import SwiftUI

struct ReviewFilterSheetView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var bookViewModel: BookViewModel
    
    var body: some View {
        NavigationStack {
            SingleSelectListView(
                title: "Choose the sort type",
                items: BookViewModel.ReviewSortOption.allCases.map { $0.rawValue },
                selectedItem: Binding(
                    get: { bookViewModel.selectedSortOption.rawValue },
                    set: { newValue in
                        if let newOption = BookViewModel.ReviewSortOption(rawValue: newValue ?? "unknown") {
                            bookViewModel.selectedSortOption = newOption
                        }
                        isPresented = false
                    }
                ),
                itemNameProvider: { $0 }
            )
        }
    }
}
