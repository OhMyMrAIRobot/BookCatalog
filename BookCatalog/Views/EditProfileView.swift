//
//  EditProfileView.swift
//  BookCatalog
//
//  Created by Daniil on 8.02.25.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    
    @State private var isEditing = false
    @State private var selectedGenres: Set<String> = []
    @State private var selectedAuthors: Set<String> = []
    
    var body: some View {
        NavigationStack {
            Text("Edit profile")
                .font(.system(size: 32))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                ProfileRow(title: "Name", value: profileViewModel.profile?.name ?? "", field: "name")
                ProfileRow(title: "Surname", value: profileViewModel.profile?.surname ?? "", field: "surname")
                ProfileRow(title: "Age", value: "\(profileViewModel.profile?.age ?? 0)", field: "age")
                ProfileRow(title: "Country", value: profileViewModel.profile?.country ?? "", field: "country")
                ProfileRow(title: "About", value: profileViewModel.profile?.about ?? "", field: "about")
                
                NavigationLink("Select Genres",
                    destination: MultiSelectListView(items: catalogViewModel.genres.keys.sorted(),
                                                     selectedItems: $selectedGenres,
                                                     itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" })
                )
                
//                NavigationLink("Select Authors",
//                    destination: MultiSelectListView(items: catalogViewModel.genres.keys.sorted(),
//                                                     selectedItems: $selectedGenres,
//                                                     itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" })
//                )
            }
        }
        .navigationTitle("edit")
    }
}

struct ProfileRow: View {
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
                   // profileViewModel.updateProfileField(field: field, value: value)
                    isEditing = false
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
            }
            
            Button(action: { isEditing.toggle() }) {
                Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                    .foregroundColor(isEditing ? .green : .blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}

#Preview {
    EditProfileView()
}
