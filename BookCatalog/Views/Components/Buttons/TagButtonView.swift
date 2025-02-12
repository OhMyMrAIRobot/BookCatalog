//
//  TagButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct TagButtonView: View {
    let title: String
    let fontSize: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .font(.system(size: fontSize))
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.gradientColor)
                .foregroundStyle(Color.white)
                .clipShape(Capsule())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
