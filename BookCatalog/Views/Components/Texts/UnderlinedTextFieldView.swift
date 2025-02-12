//
//  UnderlinedTextFieldView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct UnderlinedTextFieldView: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(isFocused ? Color.gradientColor : Color.gradientGray)
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 20))
                        .tint(Color.gradientColor)
                        .focused($isFocused)
                } else {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 20))
                        .tint(Color.gradientColor)
                        .focused($isFocused)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 5)
                .foregroundStyle(Color.gradientColor)
        }
    }
}
