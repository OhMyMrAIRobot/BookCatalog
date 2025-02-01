//
//  FavouriteView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

struct FavouriteView : View {
    
    @State var navigationPath = NavigationPath()
    @EnvironmentObject var favouriteViewModel : FavouriteViewModel
    
    var body : some View {
        VStack {
            NavigationStack(path: $navigationPath) {
                Text("Favourite books")
                    .font(.system(size: 32))
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    
                }
                
                .padding(.horizontal)
                .scrollIndicators(.hidden)
            }
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    FavouriteView()
}
