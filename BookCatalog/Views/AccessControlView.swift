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
    @ViewBuilder
    var body: some View {
        ZStack {
            if authService.isLoggedIn {
                MainView()
            } else {
                AuthView()
            }
        }
    }
}

#Preview {
    AccessControlView()
}
