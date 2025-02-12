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
        VStack {
            Text("Edit profile")
                .font(.system(size: 36))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxHeight: 40)
            
            VStack(spacing: 16) {
                EditRowView(title: "Name", value: profileViewModel.profile?.name ?? "", field: "name")
                EditRowView(title: "Surname", value: profileViewModel.profile?.surname ?? "", field: "surname")
                EditRowView(title: "Age", value: "\(profileViewModel.profile?.age ?? 0)", field: "age")
                EditRowView(title: "Country", value: profileViewModel.profile?.country ?? "", field: "country")
                EditRowView(title: "About", value: profileViewModel.profile?.about ?? "", field: "about")
                
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
                    SelectionRowView(
                        title: "Gender",
                        selectedItems: profileViewModel.selectedGender.map { Set([$0.rawValue]) } ?? [],
                        onTap: {},
                        displayNames: { $0 }
                    )
                }
                
                
                NavigationLink(destination: MultiSelectListView(
                    title: "Select genres",
                    items: catalogViewModel.genres.keys.sorted {
                        (catalogViewModel.genres[$0]?.name ?? "") < (catalogViewModel.genres[$1]?.name ?? "")
                    },
                    selectedItems: $profileViewModel.selectedGenres,
                    itemNameProvider: { catalogViewModel.genres[$0]?.name ?? "" }
                )) {
                    SelectionRowView(
                        title: "Genres",
                        selectedItems: profileViewModel.selectedGenres,
                        onTap: {},
                        displayNames: { catalogViewModel.genres[$0]?.name ?? "" }
                    )
                }
                
                
                NavigationLink(destination: MultiSelectListView(
                    title: "Select authors",
                    items: catalogViewModel.authors.keys.sorted {
                        (catalogViewModel.authors[$0]?.name ?? "") < (catalogViewModel.authors[$1]?.name ?? "")
                    },
                    selectedItems: $profileViewModel.selectedAuthors,
                    itemNameProvider: { "\(catalogViewModel.authors[$0]?.name ?? "") \(catalogViewModel.authors[$0]?.surname ?? "")"}
                )) {
                    SelectionRowView(
                        title: "Authors",
                        selectedItems: profileViewModel.selectedAuthors,
                        onTap: {},
                        displayNames: { "\(catalogViewModel.authors[$0]?.name.prefix(1) ?? ""). \(catalogViewModel.authors[$0]?.surname ?? "")"
                        }
                    )
                }
            }
            .padding(.top, 15)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.white.opacity(0.9))

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gradientColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
    }
}
