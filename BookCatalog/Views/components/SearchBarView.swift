//
//  SearchBarView.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import SwiftUI

struct SearchBarView : View {
    @Binding var searchText: String
    @State private var isFilterActive: Bool = false
    
    var body : some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search books here...", text: $searchText)
                .autocorrectionDisabled(true)
                .accentColor(.black)
            
            Button(action: {
                isFilterActive.toggle()
            }) {
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title)
                    .background(.white)
                    .foregroundColor(isFilterActive ? .black : .gray)
            }
            .padding(.trailing, 10)
            .sheet(isPresented: $isFilterActive) {
                FilterModalView(isPresented: $isFilterActive)
                    .presentationDetents([.height(300), .fraction(0.5)]) 
                    .presentationDragIndicator(.visible)
            }
        }
        .padding(15)
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

//#Preview {
//    @State var text: String = ""
//    SearchBarView(searchText: $text)
//}
