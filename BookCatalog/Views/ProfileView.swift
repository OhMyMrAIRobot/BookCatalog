//
//  ProfileView.swift
//  BookCatalog
//
//  Created by Daniil on 30.01.25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    
    @State private var isDataLoaded = false
    @State private var navigateToEditProfile = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack{}.frame(maxWidth: .infinity, maxHeight: 60)
            
            ScrollView {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.black)
                    .background(.white)
                    .clipShape(Circle())
                
                if let profile = profileViewModel.profile {
                    HStack(spacing: 12) {
                        Text(profile.name.isEmpty && profile.surname.isEmpty ? "Name not specified" : "\(profile.name) \(profile.surname)")
                            .padding(.bottom, 0.5)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .bold()
                            .font(.system(size: 18))
                            .onTapGesture {
                                do { try AuthService.shared.signOut() } catch {}
                            }
                    }.padding(.horizontal)
                    
                    Text(profile.email)
                        .padding(.horizontal)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    
                    HStack() {
                        ProfileInfoColumnView(title: "Country", value: profile.country.isEmpty ? "None" : profile.country)
                        ProfileInfoColumnView(title: "Age", value: "\(profile.age)")
                        ProfileInfoColumnView(title: "Gender", value: profile.gender.isEmpty ? "None" : profile.gender)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .purple, radius: 2, x: 0, y: 2)
                    .padding(.horizontal)
                    .padding(.top, 10)

                    HStack(spacing: 15) {
                        ProfileActionButtonView(title: "Edit my profile", invert: true) {
                            navigateToEditProfile = true
                        }
                        
                        ProfileActionButtonView(title: "Delete my profile") {
                            showDeleteAlert = true
                        }
                    }
                    .padding(.top, 15)
                    
                    ConfirmAlertView(
                        showAlert: $showDeleteAlert,
                        title: "Are you sure to delete profile?",
                        message: "This action cannot be undone."
                    ) {
                        Task { await profileViewModel.deleteProfile() }
                    }

                    if !profile.about.isEmpty {
                        VStack(alignment: .leading) {
                            Text("About me")
                                .font(.system(size: 20))
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.gradientColor)
                            
                            ExpandableTextView(
                                fullText: profile.about,
                                lines: 3)
                            .font(.system(size: 18))
                            .foregroundColor(Color(.black).opacity(0.6))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .purple, radius: 2, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    }

                    if !profile.favGenreIds.isEmpty {
                        ProfileTagSectionView(
                            title: "Favourite genres",
                            tags: profile.favGenreIds.compactMap { catalogViewModel.genres[$0]?.name }
                        )
                        .padding(.horizontal)
                        .padding(.top, 15)
                    }

                    if !profile.favAuthorIds.isEmpty {
                        ProfileTagSectionView(
                            title: "Favourite authors",
                            tags: profile.favAuthorIds.compactMap {"\(catalogViewModel.authors[$0]?.name.prefix(1) ?? ""). \(catalogViewModel.authors[$0]?.surname ?? "")"}
                        )
                        .padding(.horizontal)
                        .padding(.top, 15)
                    }

                    
                } else {
                    CustomProgressView(text: "Loading profile...")
                        .background(Color.gradientColor)
                }
            }
            .padding(.top, -50)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.white.opacity(0.9))
            .scrollIndicators(.hidden)
            .onAppear {
                Task {
                    if !isDataLoaded {
                        await profileViewModel.fetchProfile()
                        isDataLoaded = true
                    }
                }
            }
            .refreshable {
                await profileViewModel.fetchProfile()
            }
            .navigationDestination(isPresented: $navigateToEditProfile) {
                EditProfileView()
                    .environmentObject(profileViewModel)
                    .environmentObject(catalogViewModel)
            }
        }

    }
}

