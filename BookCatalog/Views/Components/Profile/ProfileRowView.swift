//
//  ProfileRow.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import SwiftUI

struct ProfileRowView: View {
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
                    .foregroundColor(isEditing ? .green : .black)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}
