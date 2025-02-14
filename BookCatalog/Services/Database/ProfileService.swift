//
//  ProfileService.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import FirebaseFirestore

class ProfileService {
    private let db: Firestore
    
    init(databaseService: DatabaseService) {
        self.db = databaseService.db
    }
    
    private var profilesRef: CollectionReference { return db.collection("Profiles") }
    
    
    func setProfile(profile: Profile) async throws -> () {
        do {
            try profilesRef.document(profile.id).setData(from: profile)
        } catch {
            throw error
        }
    }
    
    
    func getProfileById(profileId: String) async throws -> Profile {
        let document = try await profilesRef.document(profileId).getDocument()
        
        guard let profile = try? document.data(as: Profile.self) else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])
        }
        
        return profile
    }
    
    
    func toggleFavouriteBook(bookId: String) async throws -> Bool {
        guard let userId = AuthService.shared.getUserId() else {
            return false
        }
        
        do {
            let document = try await profilesRef.document(userId).getDocument()
            
            guard document.exists,
                let data = document.data()
            else {
                return false
            }
            
            var favouriteBookIds = data["favBookIds"] as? [String] ?? []
            if favouriteBookIds.contains(bookId) {
                favouriteBookIds.removeAll { $0 == bookId }
            } else {
                favouriteBookIds.append(bookId)
            }

            try await profilesRef.document(userId).updateData(["favBookIds": favouriteBookIds])
            
            return true
        } catch {
            return false
        }
    }
    
    
    func getFavouriteBookIds() async throws -> [String] {
        guard let userId = AuthService.shared.getUserId() else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user id found"])
        }
        
        let document = try await profilesRef.document(userId).getDocument()
        
        guard document.exists,
            let data = document.data()
        else {
            throw NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Profile not found"])
        }

        guard let favouriteBookIds = data["favBookIds"] as? [String] else {
            throw NSError(domain: "Firestore", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid data format for favBookIds"])
        }
        
        return favouriteBookIds
    }
    
    
    func deleteProfile() async throws {
        guard let userId = AuthService.shared.getUserId() else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user id found"])
        }
        
        do {
            try await profilesRef.document(userId).delete()
            print("profile deleted")
        } catch {
            print(error)
            throw error
        }
    }
}
