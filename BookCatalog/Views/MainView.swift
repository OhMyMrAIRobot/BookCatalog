//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var mainViewModel = MainViewModel()
    @State private var selectedTab: Int = 0
    
    @State var text = ""

    var body: some View {
        VStack {
            Text("Book list")
                .font(.system(size: 32))
                .fontDesign(.rounded) // TODO: найти норм шрифт
                .fontWeight(.semibold)
                .padding(.bottom, 20)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SearchBarView(searchText: $text)
            
            ScrollView {
                BookCardView(book: Book(), author: Author(), genre: Genre())
            }
            
            NavigationBar(selectedTab: $selectedTab)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainView()
}
