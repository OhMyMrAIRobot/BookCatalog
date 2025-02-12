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
        VStack(alignment: .leading) {
            Text("Choose the sort type")
                .padding(.top, 20)
                .padding(.leading)
                .font(.title)
                .bold()
                .foregroundStyle(.black)

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
            .shadow(color: .purple, radius: 2, x: 0, y: 2)
        }.background(Color.white.opacity(0.9))
    }
}
