//
//  ErrorAlertView.swift
//  BookCatalog
//
//  Created by Daniil on 14.02.25.
//

import SwiftUI

struct ErrorAlertView: View {
    @Binding var showAlert: Bool
    var title: String
    var message: String
    var dismissButtonText: String

    var body: some View {
        VStack {
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text(dismissButtonText)) {
                    showAlert = false
                }
            )
        }
    }
}
