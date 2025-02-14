//
//  AuthView.swift
//  BookCatalog
//
//  Created by Daniil on 25.01.25.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image("Preview")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding(.top, 45.0)
                
                Spacer()
            }
            .zIndex(1)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gradientColor)
            
            AuthFormView(serviceContainer: serviceContainer)
                .zIndex(100)
        }
        
    }
}
