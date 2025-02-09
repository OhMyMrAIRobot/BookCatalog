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
    let services: ServiceContainer
    
    @EnvironmentObject var authService: AuthService

    @StateObject private var favouriteViewModel: FavouriteViewModel
    @StateObject private var catalogViewModel: CatalogViewModel
    @StateObject private var ratingViewModel: RatingViewModel
    @StateObject private var profileViewModel: ProfileViewModel
    
    init() {
        let services = ServiceContainer()
        self.services = services
        _favouriteViewModel = StateObject(wrappedValue: FavouriteViewModel(container: services))
        _catalogViewModel = StateObject(wrappedValue: CatalogViewModel(container: services))
        _ratingViewModel = StateObject(wrappedValue: RatingViewModel(container: services))
        _profileViewModel = StateObject(wrappedValue: ProfileViewModel(container: services))
    }
    
    @State private var selectedTab = 0
    
    var body: some View {
            VStack(spacing: 0) {
                if authService.isLoading {
                    ProgressView("Checking authorization...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if authService.isLoggedIn {
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
            .environmentObject(services)
            .background(Color(.systemGray6))
            .edgesIgnoringSafeArea(.bottom)
            .onChange(of: authService.isLoggedIn) { newValue, oldValue in
                selectedTab = 0
            }
        
    }
}

