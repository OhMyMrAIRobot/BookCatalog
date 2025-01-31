//
//  FavouriteView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

struct FavouriteView : View {
    
    var body : some View {
        VStack {
            Text("Favourites")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    FavouriteView()
}
