//
//  BookImageView.swift
//  BookCatalog
//
//  Created by Daniil on 10.02.25.
//

import SwiftUI

struct BookImageView: View {
    let imageUrl: String
    @State private var reloadToken = UUID()

    var body: some View {
        CachedAsyncImage(url: URL(string: imageUrl + "?\(reloadToken)")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.black)
                    .frame(maxHeight: .infinity)
            case .success(let image):
                image
                    .resizable()
            case .failure:
                VStack {
                    Text("Failed to load image")
                        .foregroundColor(.red)
                        
                    Button(action: {
                        reloadToken = UUID()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                    .padding()
                }.frame(maxHeight: .infinity)
            @unknown default:
                EmptyView()
            }
        }
    }
}

