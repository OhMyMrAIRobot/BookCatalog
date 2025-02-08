//
//  MultiSelectListView.swift
//  BookCatalog
//
//  Created by Daniil on 8.02.25.
//

import SwiftUI

struct MultiSelectListView: View {
    let title: String
    let items: [String]
    @Binding var selectedItems: Set<String>
    let itemNameProvider: (String) -> String
    
    var body: some View {
        List(items, id: \..self) { item in
            HStack {
                Text(itemNameProvider(item))
                Spacer()
                if selectedItems.contains(item) {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if selectedItems.contains(item) {
                    selectedItems.remove(item)
                } else {
                    selectedItems.insert(item)
                }
            }
        }
        .navigationTitle(title)
    }
}
