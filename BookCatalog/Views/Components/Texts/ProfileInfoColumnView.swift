//
//  ProfileInfoColumnView.swift
//  BookCatalog
//
//  Created by Daniil on 11.02.25.
//

import SwiftUI

struct ProfileInfoColumnView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.gradientColor)
            
            Text(value)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.gray)
        }
        .frame(maxWidth: .infinity)
    }
}
