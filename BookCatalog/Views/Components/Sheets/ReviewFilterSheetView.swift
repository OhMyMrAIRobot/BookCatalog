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
        NavigationView {
            List {
                ForEach(BookViewModel.ReviewSortOption.allCases, id: \.self) { option in
                    Button {
                        bookViewModel.selectedSortOption = option
                        isPresented = false
                    } label: {
                        HStack {
                            Text(option.rawValue)
                                .fontWeight(bookViewModel.selectedSortOption == option ? .semibold : .regular)
                            Spacer()
                            if bookViewModel.selectedSortOption == option {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                        }
                    }.foregroundColor(.black)
                }
            }
            .padding(.top, 10)
            .navigationTitle("Choose the sort type")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

//#Preview {
//    @State var selectedSortOption: ReviewSortOption = .dateDescending
//    ReviewFilterSheetView(isPresented: .constant(true), selectedSortOption: $selectedSortOption)
//}
