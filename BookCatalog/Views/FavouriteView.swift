//
//  FavouriteView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

struct FavouriteView : View {
    @Binding var selectedTab: Int
    
    var body : some View {
        VStack {
            Text("Favourites")
            
            Spacer()
            
            NavigationBar(selectedTab: $selectedTab)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    FavouriteView(selectedTab: .constant(1))
}
