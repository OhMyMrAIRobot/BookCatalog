//
//  ConfirmAlertView.swift
//  BookCatalog
//
//  Created by Daniil on 11.02.25.
//

import SwiftUI

struct ConfirmAlertView: View {
    @Binding var showAlert: Bool
    var title: String
    var message: String
    var onConfirm: () -> Void
    
    var body: some View {
        VStack {}
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .destructive(Text("Confirm")) {
                    onConfirm()
                    showAlert = false
                },
                secondaryButton: .cancel {
                    showAlert = false
                }
            )
        }
    }
}
