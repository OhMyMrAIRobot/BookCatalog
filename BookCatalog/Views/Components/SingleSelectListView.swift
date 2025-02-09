//
//  SingleSelectListView.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import SwiftUI

struct SingleSelectListView: View {
    let title: String
    let items: [String]
    @Binding var selectedItem: String?
    let itemNameProvider: (String) -> String
    
    var body: some View {
        List(items, id: \.self) { item in
            Button {
                selectedItem = item
            } label: {
                HStack {
                    Text(itemNameProvider(item))
                        .fontWeight(selectedItem == item ? .semibold : .regular)
                    Spacer()
                    if selectedItem == item {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                    }
                }
            }.foregroundColor(.black)
        }
        .navigationTitle(title)
    }
}
