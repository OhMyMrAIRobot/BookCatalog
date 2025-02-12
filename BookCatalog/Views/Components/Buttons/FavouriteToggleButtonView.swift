//
//  FavouriteToggleButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct FavouriteToggleButtonView: View {
    let isFavourite: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .foregroundStyle(isFavourite ? .red : .gray)
                .font(.system(size: 30))
        }
    }
}
