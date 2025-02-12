//
//  SignButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct SignButtonView: View {
    let title: String
    var invert: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(invert ? Color.gradientColor : Color.gradientWhite)
                .background(invert ? Color.gradientWhite : Color.gradientColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gradientColor, lineWidth: 2)
                )
        }
    }
}
