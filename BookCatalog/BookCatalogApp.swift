//
//  BookCatalogApp.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    return true
  }
}

@main
struct BookCatalogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authService = AuthService.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AccessControlView()
                    .environmentObject(authService)
                    .preferredColorScheme(.light)
                    
            }
        }
    }
}
