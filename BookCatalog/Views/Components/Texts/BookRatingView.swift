//
//  BookRatingView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct BookRatingView: View {
    let fontSize: CGFloat
    let rating: Double
    
    var body: some View {
        HStack(spacing: 1.5) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.system(size: fontSize))
                .bold()
            
            Text(String(format: "%.1f", rating))
                .font(.system(size: fontSize))
                .bold()
        }
    }
}
