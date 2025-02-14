//
//  DeleteAccountSheet.swift
//  BookCatalog
//
//  Created by Daniil on 14.02.25.
//

import SwiftUI

struct DeleteAccountSheet: View {
    @Binding var isPresented: Bool
    @Binding var password: String
    let onConfirm: () -> Void

    
    var body: some View {
        VStack(spacing: 20) {
            Text("Confirm password")
                .padding(.top, 20)
                .padding(.leading)
                .font(.title)
                .bold()
                .foregroundStyle(.black)
            
            UnderlinedTextFieldView(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
            
            HStack(spacing: 10) {
                PostReviewButtonView(title: "Cancel") { isPresented = false }
                
                PostReviewButtonView(title: "Delete", isInvert: false) {
                    Task {
                        onConfirm()
                        isPresented = false
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .background(.white.opacity(0.9))
    }
}
