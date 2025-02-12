//
//  SelectionRowView.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import SwiftUI

struct SelectionRowView: View {
    let title: String
    let selectedItems: Set<String>
    let onTap: () -> Void
    let displayNames: (String) -> String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .frame(width: 100, alignment: .leading)
                .foregroundStyle(Color.gradientColor)
            
            Text(selectedItems.isEmpty ? "None selected" : selectedItems.map(displayNames).joined(separator: ", "))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.gray)
                .lineLimit(1)

            Button(action: onTap) {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.gradientColor)
            }
        }
        .padding()
        .background(Color.white)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .purple, radius: 2, x: 0, y: 2)
    }
}
