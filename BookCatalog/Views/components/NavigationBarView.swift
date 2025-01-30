//
//  NavigationBar.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct NavigationBar : View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            
            // Books Tab
            NavigationTabItem(
                icon: "book.fill",
                label: "Books",
                isSelected: selectedTab == 0
            ) {
                selectedTab = 0
            }

            Spacer()
            
            // Favourite Tab
            NavigationTabItem(
                icon: "star.fill",
                label: "Favourite",
                isSelected: selectedTab == 1

            ) {
                selectedTab = 1
            }

            Spacer()
            
            // Profile Tab
            NavigationTabItem(
                icon: "person.fill",
                label: "Profile",
                isSelected: selectedTab == 2
            ) {
                selectedTab = 2
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 8)
        .padding(.bottom, 24)
    }
}

struct NavigationTabItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .black : .gray)
                
                Text(label)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? .black : .gray)
            }
        }
    }
}


#Preview {
    MainView(selectedTab: .constant(0))
}
