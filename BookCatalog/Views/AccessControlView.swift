//
//  AccessControlView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI
import FirebaseAuth

struct AccessControlView : View {
    @StateObject var authController = AuthController()
    @StateObject var authService = AuthService()
    
    @ViewBuilder
    var body: some View {
        ZStack {
            if authController.isSignedIn {
                MainView()
            } else {
                AuthView().environmentObject(authController)
            }
        }.onAppear{
            authController.isSignedIn = authService.isAuth()
        }
    }
}

#Preview {
    AccessControlView()
}
