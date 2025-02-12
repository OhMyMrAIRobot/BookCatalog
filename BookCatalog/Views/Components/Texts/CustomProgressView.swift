//
//  CustomProgressView.swift
//  BookCatalog
//
//  Created by Daniil on 11.02.25.
//

import SwiftUI

struct CustomProgressView: View {
    let text: String
    
    var body: some View {
            ProgressView(text)
                .progressViewStyle(CircularProgressViewStyle())
                .tint(Color.gradientColor)
                .foregroundStyle(Color.gradientColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white.opacity(0.9))
    }
}
