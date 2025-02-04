//
//  AccessControlView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct AccessControlView: View {
    @ObservedObject private var authService = AuthService.shared
    
    @ObservedObject private var favouriteViewModel = FavouriteViewModel()
    @ObservedObject private var catalogViewModel = CatalogViewModel()
    @ObservedObject private var ratingViewModel = RatingViewModel()
    
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            if authService.isLoggedIn { // authService.isLoggedIn
                TabView(selection: $selectedTab) {
                    MainView()
                        .tag(0)
                        .environmentObject(favouriteViewModel)
                        .environmentObject(catalogViewModel)
                        .environmentObject(ratingViewModel)
                    
                    
                    FavouriteView()
                        .tag(1)
                        .environmentObject(favouriteViewModel)
                        .environmentObject(catalogViewModel)
                        .environmentObject(ratingViewModel)
                    
                    ProfileView()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onAppear {
                    Task {
                        await favouriteViewModel.fetchFavouriteBookIds()
                    }
                }
                
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
