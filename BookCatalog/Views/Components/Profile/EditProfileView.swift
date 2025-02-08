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
            
            NavigationLink(destination: MultiSelectListView(
                title: "Select genres",
                items: catalogViewModel.genres.keys.sorted {
                    (catalogViewModel.genres[$0]?.name ?? "") < (catalogViewModel.genres[$1]?.name ?? "")
                },
                selectedItems: $selectedGenres,
                itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" }
            )) {
                ProfileSelectionRow(
                    title: "Genres",
                    selectedItems: selectedGenres,
                    onTap: {},
                    displayNames: { catalogViewModel.genres[$0]?.name ?? "" }
                )
            }.buttonStyle(PlainButtonStyle())
            
            
            NavigationLink(destination: MultiSelectListView(
                title: "Select authors",
                items: catalogViewModel.authors.keys.sorted {
                    (catalogViewModel.authors[$0]?.name ?? "") < (catalogViewModel.authors[$1]?.name ?? "")
                },
                selectedItems: $selectedAuthors,
                itemNameProvider: { "\(catalogViewModel.authors[$0]?.name ?? "") \(catalogViewModel.authors[$0]?.surname ?? "")"}
            )) {
                ProfileSelectionRow(
                    title: "Authors",
                    selectedItems: selectedAuthors,
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
