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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            List(items, id: \.self) { item in
                Button {
                    selectedItem = item
                    dismiss()
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
                }
                .foregroundStyle(Color.black)
            }
            .background(.white.opacity(0.9))
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(title)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
        .background(Color.gradientColor)
    }
}
