//
//  ProfileViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 6.02.25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private let profileService: ProfileService
    private let reviewService: ReviewService
    
    init(container: ServiceContainer) {
        self.profileService = container.profileService
        self.reviewService = container.reviewService
    }
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
    }
    
    @Published var profile: Profile? = nil
    @Published var reviewProfiles: [String: Profile] = [:]
    
    @Published var selectedAuthors: Set<String> = [] {
        didSet {
            Task { await updateProfileField(field: "authors", value: selectedAuthors) }
        }
    }

    @Published var selectedGenres: Set<String> = [] {
        didSet {
            Task { await updateProfileField(field: "genres", value: selectedGenres) }
        }
    }
    
    @Published var selectedGender: Gender? {
        didSet {
            Task { await updateProfileField(field: "gender", value: selectedGender?.rawValue ?? "") }
        }
    }

    
    @MainActor
    func fetchProfile() async {
        do {
            let userId = AuthService.shared.getUserId()
            let fetchedProfile = try await profileService.getProfileById(profileId: userId ?? "")
            self.profile = fetchedProfile
            
            self.selectedAuthors = Set(fetchedProfile.favAuthorIds)
            self.selectedGenres = Set(fetchedProfile.favGenreIds)
            self.selectedGender = Gender(rawValue: fetchedProfile.gender)
        } catch {
            print("Failed to fetch profile \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchReviewProfiles(reviews: [Review]) async {
        for review in reviews {
            do {
                let profile = try await profileService.getProfileById(profileId: review.userId)
                reviewProfiles[profile.id] = profile
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func updateProfileField(field: String, value: Any) async {
        guard var profile = profile else {
            print("Profile is nil")
            return
        }
        
        let savedProfile = profile
        
        switch field {
        case "name":
            if let name = value as? String {
                profile.name = name
            }
        case "surname":
            if let surname = value as? String {
                profile.surname = surname
            }
        case "country":
            if let country = value as? String {
                profile.country = country
            }
        case "about":
            if let about = value as? String {
                profile.about = about
            }
        case "age":
            if let ageString = value as? String, let age = Int(ageString), age >= 0 && age <= 100 {
                profile.age = age
            }
        case "gender":
            if let gender = value as? String {
                profile.gender = gender
            }
        case "authors":
            if let authors = value as? Set<String> {
                profile.favAuthorIds = Array(authors)
            }
        case "genres":
            if let genres = value as? Set<String> {
                profile.favGenreIds = Array(genres)
            }
        default:
            print("Unknown field: \(field)")
            return
        }
        
        do {
            try await profileService.setProfile(profile: profile)
            self.profile = profile
        } catch {
            print(error.localizedDescription)
            self.profile = savedProfile
        }
    }
    
    @MainActor
    func deleteProfile(email: String, password: String) async throws {
        do {
            try await AuthService.shared.reauthenticateUser(email: email, password: password)
            try await profileService.deleteProfile()
            try await reviewService.deleteUserReviews()
            try await AuthService.shared.deleteUser()
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
