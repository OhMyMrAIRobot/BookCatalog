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
            NavigationTabItem(
                icon: "book",
                label: "Books",
                isSelected: selectedTab == 0
            ) {
                selectedTab = 0
            }
            .frame(maxWidth: .infinity)
    
            NavigationTabItem(
                icon: "star",
                label: "Favourite",
                isSelected: selectedTab == 1
            ) {
                selectedTab = 1
            }
            .frame(maxWidth: .infinity)
            
            NavigationTabItem(
                icon: "person",
                label: "Profile",
                isSelected: selectedTab == 2
            ) {
                selectedTab = 2
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 10)
        .padding(.top, 8)
        .padding(.bottom, 24)
        .overlay(
            Rectangle()
                .fill(Color.gray).opacity(0.6)
                .frame(height: 2), alignment: .top
        )
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
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(isSelected ? .purple : .gray)
                
                Text(label)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(isSelected ? .purple : .gray)
            }
        }
    }
}


#Preview {
    NavigationBar(selectedTab: .constant(1))
}
