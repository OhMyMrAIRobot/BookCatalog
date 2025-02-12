//
//  PostReviewButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 12.02.25.
//

import SwiftUI

struct PostReviewButtonView: View {
    let title: String
    var isInvert: Bool = true
    var isDisabled: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .bold()
                .background(backgroundColor)
                .foregroundStyle(isInvert ? .black : .white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isDisabled ? Color.gray : Color.black, lineWidth: 2)
                )
        }
        .disabled(isDisabled)
    }
    
    private var backgroundColor: Color {
        if isInvert { return .white }
        if isDisabled { return .gray }
        return .black
    }
}
