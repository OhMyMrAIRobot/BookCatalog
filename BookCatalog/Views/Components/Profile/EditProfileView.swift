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
    
    @State private var selectedAge: Int = 18
    
    var body: some View {
        Text("Edit profile")
            .font(.system(size: 32))
            .fontDesign(.rounded)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .padding(.leading, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        VStack(spacing: 16) {
            ProfileRowView(title: "Name", value: profileViewModel.profile?.name ?? "", field: "name")
            ProfileRowView(title: "Surname", value: profileViewModel.profile?.surname ?? "", field: "surname")
            ProfileRowView(title: "Age", value: "\(profileViewModel.profile?.age ?? 0)", field: "age")
            ProfileRowView(title: "Country", value: profileViewModel.profile?.country ?? "", field: "country")
            ProfileRowView(title: "About", value: profileViewModel.profile?.about ?? "", field: "about")
            
            NavigationLink(destination: SingleSelectListView(
                title: "Choose the gender",
                items: ProfileViewModel.Gender.allCases.map { $0.rawValue },
                selectedItem: Binding(
                    get: { profileViewModel.selectedGender?.rawValue },
                    set: { newValue in
                        if let newOption = ProfileViewModel.Gender(rawValue: newValue ?? "unknown") {
                            profileViewModel.selectedGender = newOption
                        }
                    }
                ),
                itemNameProvider: { $0 }
            )) {
                ProfileSelectionRowView(
                    title: "Gender",
                    selectedItems: profileViewModel.selectedGender.map { Set([$0.rawValue]) } ?? [],
                    onTap: {},
                    displayNames: { $0 }
                )
            }.buttonStyle(PlainButtonStyle())

            
            NavigationLink(destination: MultiSelectListView(
                title: "Select genres",
                items: catalogViewModel.genres.keys.sorted {
                    (catalogViewModel.genres[$0]?.name ?? "") < (catalogViewModel.genres[$1]?.name ?? "")
                },
                selectedItems: $profileViewModel.selectedGenres,
                itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" }
            )) {
                ProfileSelectionRowView(
                    title: "Genres",
                    selectedItems: profileViewModel.selectedGenres,
                    onTap: {},
                    displayNames: { catalogViewModel.genres[$0]?.name ?? "" }
                )
            }.buttonStyle(PlainButtonStyle())
            
            
            NavigationLink(destination: MultiSelectListView(
                title: "Select authors",
                items: catalogViewModel.authors.keys.sorted {
                    (catalogViewModel.authors[$0]?.name ?? "") < (catalogViewModel.authors[$1]?.name ?? "")
                },
                selectedItems: $profileViewModel.selectedAuthors,
                itemNameProvider: { "\(catalogViewModel.authors[$0]?.name ?? "") \(catalogViewModel.authors[$0]?.surname ?? "")"}
            )) {
                ProfileSelectionRowView(
                    title: "Authors",
                    selectedItems: profileViewModel.selectedAuthors,
                    onTap: {},
                    displayNames: { "\(catalogViewModel.authors[$0]?.name.prefix(1) ?? ""). \(catalogViewModel.authors[$0]?.surname ?? "")"
                    }
                )
            }.buttonStyle(PlainButtonStyle())
        }
        
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
