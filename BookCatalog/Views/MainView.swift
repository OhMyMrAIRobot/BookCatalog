//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            NavigationBar(selectedTab: $selectedTab)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainView()
}
