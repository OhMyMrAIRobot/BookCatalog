//
//  BookImageView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct BookImageView: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.black)
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Text("Failed to load image")
            @unknown default:
                EmptyView()
            }
        }
    }
}
