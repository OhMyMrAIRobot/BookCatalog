//
//  ProfileViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 6.02.25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile? = nil
    @Published var reviewProfiles: [String: Profile] = [:]
    @Published var userId = AuthService.shared.getUserId()
    
    @MainActor
    func fetchProfile() async {
        do {
            self.profile = try await DatabaseService.shared.getProfileById(profileId: userId ?? "")
        } catch {
            print("Failed to fetch profile \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchReviewProfiles(reviews: [Review]) async {
        for review in reviews {
            do {
                let profile = try await DatabaseService.shared.getProfileById(profileId: review.userId)
                reviewProfiles[profile.id] = profile
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
