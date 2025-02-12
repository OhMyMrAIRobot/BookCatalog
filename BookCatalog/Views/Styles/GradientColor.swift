//
//  GradientForeground.swift
//  BookCatalog
//
//  Created by Daniil on 9.02.25.
//

import SwiftUI

extension Color {
    static var gradientColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 170 / 255, green: 150 / 255, blue: 250 / 255),
                Color(red: 210 / 255, green: 140 / 255, blue: 255 / 255)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static var gradientWhite: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),
                Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static var gradientGray: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 128 / 255, green: 128 / 255, blue: 128 / 255),
                Color(red: 128 / 255, green: 128 / 255, blue: 128 / 255)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
