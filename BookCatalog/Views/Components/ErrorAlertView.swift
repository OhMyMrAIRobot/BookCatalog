//
//  ErrorAlertView.swift
//  BookCatalog
//
//  Created by Daniil on 27.01.25.
//

import SwiftUI

struct ErrorAlert : View {
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

struct ErrorAlert_Previews: PreviewProvider {
    @State static var showAlert = true

    static var previews: some View {
        ErrorAlert(
            showAlert: $showAlert,
            title: "Warning!",
            message: "Something went wrong!",
            dismissButtonText: "Close"
        )
    }
}
