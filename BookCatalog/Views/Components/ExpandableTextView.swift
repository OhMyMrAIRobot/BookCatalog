//
//  ExpandableTextView.swift
//  BookCatalog
//
//  Created by Daniil on 1.02.25.
//

import SwiftUI

struct ExpandableTextView: View {
    let fullText: String
    @State private var isExpanded = false
    let lines: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(fullText)
                .lineLimit(isExpanded ? nil : lines)
                .padding(.bottom, 1)
                .animation(.smooth.speed(4), value: isExpanded)

//            if needsExpansion {
                Button(isExpanded ? "Less" : "More") {
                    isExpanded.toggle()
                }
                .font(.headline)
                .foregroundColor(Color(.red).opacity(0.8))
//            }
        }
    }
}


