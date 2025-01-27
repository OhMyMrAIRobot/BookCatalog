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
            Button{
                AuthService.shared.signOut()
            } label: {
                Text("Sign out")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(.black))
                    .padding()
            }
            NavigationBar(selectedTab: $selectedTab)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainView()
}
