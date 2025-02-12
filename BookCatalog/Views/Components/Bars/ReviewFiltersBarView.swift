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
    @State private var isProfileLoading = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Button(action: { isFilterSheetActive.toggle() }) {
                    Image(systemName: "slider.horizontal.3")
                }
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white)
                .foregroundStyle(Color.gradientColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gradientColor, lineWidth: 2)
                )
                
                Spacer()
                
                Button(action: { isAddSheetActive.toggle()}) {
                    Text("\(bookViewModel.reviews.contains(where: {$0.userId == bookViewModel.userId}) ? "Edit my" : "Post new") review")
                }
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gradientColor)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gradientColor, lineWidth: 2)
                )
                
            }
            .sheet(isPresented: $isAddSheetActive) {
                if !isProfileLoading {
                    if let profile = profileViewModel.profile {
                        NewReviewSheetView(
                            isPresented: $isAddSheetActive,
                            sheetTitle: "\(bookViewModel.reviews.contains(where: {$0.userId == bookViewModel.userId}) ? "Edit my" : "Post new") review",
                            bookTitle: bookViewModel.book.title,
                            name: profile.name.isEmpty && profile.surname.isEmpty ? "Unknown user" : "\(profile.name) \(profile.surname)",
                            review: bookViewModel.reviews.first(where: { $0.userId == bookViewModel.userId })
                        )
                        .presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)
                        .presentationBackground(Color.gradientColor)
                    }
                } else {
                    ProgressView("Loading profile...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear {
                            Task {
                                await profileViewModel.fetchProfile()
                                isProfileLoading = false
                            }
                        }
                }
            }
            .sheet(isPresented: $isFilterSheetActive) {
                ReviewFilterSheetView(isPresented: $isFilterSheetActive)
                    .presentationDetents([.fraction(0.4)])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(Color.gradientColor)
            }
            
            HStack(spacing: 10) {
                FilterButtonView(title: "All", rating: nil, selectedRating: $selectedRating)
                
                ForEach(1..<6) { idx in
                    FilterButtonView(title: "\(idx)", rating: idx, selectedRating: $selectedRating)
                }
            }
        }
    }
}



