//
//  AccessControlView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI
import FirebaseAuth

struct AccessControlView : View {
    @ObservedObject var authService = AuthService.shared
    @State private var selectedTab = 0
    
    @ViewBuilder
    var body: some View {
        ZStack {
           // if authService.isLoggedIn {
            if true {
                TabView(selection: $selectedTab) {
                    MainView(selectedTab: $selectedTab)
                        .tag(0)
                    
                    FavouriteView(selectedTab: $selectedTab)
                        .tag(1)
                    
                    ProfileView(selectedTab: $selectedTab)
                        .tag(2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGray6))
                .edgesIgnoringSafeArea(.bottom)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            } else {
                AuthView()
            }
        }
    }
}

#Preview {
    AccessControlView()
}
