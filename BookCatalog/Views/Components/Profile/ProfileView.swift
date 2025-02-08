//
//  ProfileView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    
    @State private var isEditingProfile = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            if let profile = profileViewModel.profile {
                HStack(spacing: 12) {
                    Text("Daniil Khlyshchankou")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0.5)
                        .multilineTextAlignment(.center)
                    
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .bold()
                        .font(.system(size: 18))
                        .onTapGesture {
                            do {
                                try AuthService.shared.signOut()
                            } catch {
                                
                            }
                            
                        }
                }
                
                Text("gfhieemobilelegendsgmail.com")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                HStack() {
                    ProfileInfoColumn(title: "Country", value: "Belarus")
                    ProfileInfoColumn(title: "Age", value: "21")
                    ProfileInfoColumn(title: "Gender", value: "Female")
                }
                .padding(.horizontal, 0.5)
                .padding(.vertical, 10)
                .background(.white)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .cornerRadius(15)
                .padding(.top, 13)
                
                HStack(spacing: 15) {
                    NavigationLink(destination: EditProfileView()
                        .environmentObject(profileViewModel)
                        .environmentObject(catalogViewModel)
                    ){
                        Text("Edit my profile")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 9)
                            .background(Color.black.opacity(0.9))
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .bold()
                            .cornerRadius(20)
                    }
                    
                    Button(action: {}) {
                        Text("Delete my profile")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 9)
                            .background(Color.black.opacity(0.9))
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .bold()
                            .cornerRadius(20)
                    }
                }
                .padding(.top, 15)
                
                Text("About me")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ExpandableTextView(
                    fullText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                    lines: 3)
                .font(.system(size: 18))
                .padding(.top, 1)
                .foregroundColor(Color(.black).opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ProfileTagSection(title: "Favourite genres", tags: ["Fantasy", "Novel", "Triller", "Art"])
                    .padding(.top, 15)
                
                ProfileTagSection(title: "Favourite authors", tags: ["J. Autsten", "K. Thorne", "O. Nechiporenko"])
                    .padding(.top, 15)
            } else {
                ProgressView("Loading profile...")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            Task {
                await profileViewModel.fetchProfile()
            }
        }
    }
}


struct ProfileTagSection: View {
    let title: String
    let tags: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.black.opacity(0.2))
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
}


struct ProfileInfoColumn: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 15)
    }
}



