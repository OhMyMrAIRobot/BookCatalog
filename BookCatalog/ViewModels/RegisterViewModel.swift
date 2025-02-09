//
//  RegisterViewModel.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import Foundation

class RegisterViewModel: ObservableObject {
    private let profileService: ProfileService
    
    
    init(container: ServiceContainer) {
        self.profileService = container.profileService
    }
    
    
    func register(email: String, password: String, age: Int) async throws {
        let user = try await AuthService.shared.register(email: email, password: password)
        
        let profile = Profile(id: user.uid, email: email, age: age)
        
        try await profileService.setProfile(profile: profile)
    }
}
