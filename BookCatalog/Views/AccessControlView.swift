//
//  AccessControlView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI
import FirebaseAuth

struct AccessControlView: View {
    @ObservedObject var authService = AuthService.shared
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            if authService.isLoggedIn { // authService.isLoggedIn
                TabView(selection: $selectedTab) {
                    MainView()
                        .tag(0)

                    FavouriteView()
                        .tag(1)

                    ProfileView()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                NavigationBar(selectedTab: $selectedTab)
                    .background(Color(.systemGray6))
            } else {
                AuthView()
            }
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    AccessControlView()
}
