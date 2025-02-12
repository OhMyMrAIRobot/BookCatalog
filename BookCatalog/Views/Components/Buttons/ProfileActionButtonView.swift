//
//  ProfileActionButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 11.02.25.
//

import SwiftUI

struct ProfileActionButtonView: View {
    let title: String
    var invert = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 20)
                .padding(.vertical, 9)
                .foregroundStyle(invert ? Color.gradientColor : Color.gradientWhite)
                .background(invert ? Color.gradientWhite : Color.gradientColor)
                .font(.system(size: 18))
                .bold()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gradientColor, lineWidth: 2)
                )
        }
    }
}
