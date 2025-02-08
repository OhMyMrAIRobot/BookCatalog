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
    @EnvironmentObject var authService: AuthService
    
    @StateObject private var favouriteViewModel = FavouriteViewModel()
    @StateObject private var catalogViewModel = CatalogViewModel()
    @StateObject private var ratingViewModel = RatingViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()
    
    @State private var selectedTab = 0
    
    var body: some View {
            VStack(spacing: 0) {
                if authService.isLoading {
                    ProgressView("Checking authorization...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if authService.isLoggedIn { // authService.isLoggedIn
                    TabView(selection: $selectedTab) {
                        MainView()
                            .tag(0)
                        
                        FavouriteView()
                            .tag(1)
                        
                        ProfileView()
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .environmentObject(favouriteViewModel)
                    .environmentObject(catalogViewModel)
                    .environmentObject(ratingViewModel)
                    .environmentObject(profileViewModel)
                    
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
            }
        
    }
}


#Preview {
    AccessControlView()
}
