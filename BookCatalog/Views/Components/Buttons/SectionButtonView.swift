//
//  SectionButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 13.02.25.
//

import SwiftUI

struct SectionButtonView: View {
    let header: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Section(header: Text(header)) {
            Button(action: action) {
                HStack {
                    Text(text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
            }.foregroundStyle(.black)
        }
    }
}
