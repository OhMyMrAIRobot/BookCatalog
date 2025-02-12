//
//  BackButtonView.swift
//  BookCatalog
//
//  Created by Daniil on 11.02.25.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 2) {
                Image(systemName: "chevron.left")
                    .font(.title3)
                
                Text("Back")
                    .bold()
            }
            .foregroundStyle(.black)
        }
    }
}
