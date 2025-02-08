//
//  ReviewsFiltersBarView.swift
//  BookCatalog
//
//  Created by Daniil on 3.02.25.
//

import SwiftUI

struct ReviewFiltersBarView: View {
    @EnvironmentObject var bookViewModel: BookViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @Binding var selectedRating: Int?
    @State private var isAddSheetActive = false
    @State private var isFilterSheetActive = false
    private let userId = AuthService.shared.getUserId() ?? ""
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                isFilterSheetActive.toggle()
            }) {
                Image(systemName: "slider.horizontal.3")
            }
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.white)
            .foregroundColor(.black)
            .clipShape(Capsule())

            Spacer()
            
            Button(action: {
                isAddSheetActive.toggle()
            }) {
                Text("+ Review")
            }
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding(.top, 10)
        .sheet(isPresented: $isAddSheetActive) {
            if let profile = profileViewModel.profile {
                NewReviewSheetView(
                    isPresented: $isAddSheetActive,
                    sheetTitle: "Post new review",
                    bookTitle: bookViewModel.book.title,
                    name: profile.name.isEmpty && profile.surname.isEmpty ? "Unknown user" : "\(profile.name) \(profile.surname)",
                    review: bookViewModel.reviews.first(where: { $0.userId == userId })
                )
                .presentationDetents([.large, .fraction(0.8)])
                .presentationDragIndicator(.visible)
                .environmentObject(bookViewModel)
            } else {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

        }
        .sheet(isPresented: $isFilterSheetActive) {
            ReviewFilterSheetView(isPresented: $isFilterSheetActive)
                .presentationDetents([.large, .fraction(0.5)])
                .presentationDragIndicator(.visible)
        }
        
        HStack(spacing: 3) {
            FilterButton(title: "All", rating: nil, selectedRating: $selectedRating)
            
            ForEach(1..<6) { idx in
                FilterButton(title: "\(idx)", rating: idx, selectedRating: $selectedRating)
            }
        }
    }
}


struct FilterButton: View {
    let title: String
    let rating: Int?
    @Binding var selectedRating: Int?

    var body: some View {
        Button(action: {
            selectedRating = rating
        }) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "star.fill")
                    .foregroundColor(selectedRating == rating ? .white : .black)
                Text(title)
                    .foregroundColor(selectedRating == rating ? .white : .black)
            }
            .frame(maxWidth: 80, maxHeight: 20)
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .padding(.horizontal, 2)
            .padding(.vertical, 2)
            .background(selectedRating == rating ? .black : Color(.systemGray5))
            .clipShape(Capsule())
        }
        .padding(4)
    }
}



