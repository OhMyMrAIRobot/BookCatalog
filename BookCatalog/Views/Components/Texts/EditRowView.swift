//
//  EditRowView.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import SwiftUI

struct EditRowView: View {
    let title: String
    let field: String
    
    @State private var value: String
    @State private var isEditing: Bool = false
    
    @EnvironmentObject var profileViewModel: ProfileViewModel

    init(title: String, value: String, field: String) {
        self.title = title
        self.field = field
        self._value = State(initialValue: value)
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .frame(width: 100, alignment: .leading)
                .foregroundStyle(Color.gradientColor)
            
            if isEditing {
                TextField("Enter \(title.lowercased())", text: $value, onCommit: {
                    Task {
                        await profileViewModel.updateProfileField(field: field, value: value)
                        isEditing = false
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
            } else {
                Text(value)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button(action: {Task {
                if isEditing {
                    await profileViewModel.updateProfileField(field: field, value: value)
                }
                isEditing.toggle()
            }}) {
                Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                    .foregroundStyle(isEditing ? .black : .purple)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .purple, radius: 2, x: 0, y: 2)
    }
}
