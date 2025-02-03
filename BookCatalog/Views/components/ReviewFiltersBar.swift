//
//  ReviewsListView.swift
//  BookCatalog
//
//  Created by Daniil on 3.02.25.
//

import SwiftUI

struct ReviewFiltersBar: View {
    @Binding var selectedRating: Int?
    
    var body: some View {
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

#Preview(body: {
    ReviewFiltersBar(selectedRating: .constant(1))
})


