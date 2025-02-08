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
    @State private var navigationPathMain = NavigationPath()
    @State private var navigationPathFavourite = NavigationPath()
    
    @ObservedObject private var favouriteViewModel = FavouriteViewModel()
    @ObservedObject private var catalogViewModel = CatalogViewModel()
    @ObservedObject private var ratingViewModel = RatingViewModel()
    @ObservedObject private var profileViewModel = ProfileViewModel()

    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            if authService.isLoggedIn { // authService.isLoggedIn
                TabView(selection: $selectedTab) {
                    MainView(navigationPath: $navigationPathMain)
                        .tag(0)
                        .environmentObject(favouriteViewModel)
                        .environmentObject(catalogViewModel)
                        .environmentObject(ratingViewModel)
                        .environmentObject(profileViewModel)
                    
                    
                    FavouriteView(navigationPath: $navigationPathFavourite)
                        .tag(1)
                        .environmentObject(favouriteViewModel)
                        .environmentObject(catalogViewModel)
                        .environmentObject(ratingViewModel)
                        .environmentObject(profileViewModel)
                    
                    ProfileView()
                        .tag(2)
                        .environmentObject(profileViewModel)
                        .environmentObject(catalogViewModel)
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
        .onChange(of: authService.isLoggedIn) { newValue, oldValue in
            selectedTab = 0
            navigationPathMain = NavigationPath()
            navigationPathFavourite = NavigationPath()
        }
    }
}


#Preview {
    AccessControlView()
}
