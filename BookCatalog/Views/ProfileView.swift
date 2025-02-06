//
//  ProfileView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

struct ProfileView : View {
    
    var body: some View {
        VStack {
            Text("Profile")
            Button(action: {AuthService.shared.signOut()}) {
               Text("logout")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}

//#Preview {
//    FavouriteView()
//}
