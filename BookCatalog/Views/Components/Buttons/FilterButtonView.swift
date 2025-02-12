//
//  FilterButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 11.02.25.
//

import SwiftUI

struct FilterButtonView: View {
    let title: String
    let rating: Int?
    @Binding var selectedRating: Int?

    var body: some View {
        Button(action: { selectedRating = rating }) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "star.fill")
                    .foregroundStyle(selectedRating == rating ? Color.gradientWhite : Color.gradientColor)
                
                Text(title)
                    .foregroundStyle(selectedRating == rating ? Color.gradientWhite : Color.gradientColor)
            }
            .frame(maxWidth: 80, maxHeight: 20)
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .padding(.horizontal, 2)
            .padding(.vertical, 3)
            .background(selectedRating == rating ? Color.gradientColor : Color.gradientWhite)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gradientColor, lineWidth: 2)
            )
        }
    }
}
