//
//  AgeRestictionCircleView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct AgeRestictionCircleView: View {
    let age: Int
    let radius: CGFloat
    let fontSize: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(getAgeColor(age: age), lineWidth: 2)
                .frame(width: radius, height: radius)

            Text("\(age)+")
                .font(.system(size: fontSize))
                .foregroundColor(.black)
        }
    }
    
    func getAgeColor(age: Int) -> Color {
        switch age {
        case ...6: return .green
        case 7...17: return .orange
        default: return .red
        }
    }
}
