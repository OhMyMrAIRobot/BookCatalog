//
//  ProfileTagSectionView.swift
//  BookCatalog
//
//  Created by Daniil on 11.02.25.
//

import SwiftUI

struct ProfileTagSectionView: View {
    let title: String
    let tags: [String]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.gradientColor)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        TagButtonView(title: tag, fontSize: 15, action: {})
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.white)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .purple, radius: 2, x: 0, y: 2)
    }
}
