//
//  BookCardView.swift
//  BookCatalog
//
//  Created by Daniil on 29.01.25.
//

import SwiftUI

struct BookCardView : View {
    let book: Book
    let author: Author
    let genre: Genre
    @State var isFavorite: Bool = true
    
    var body : some View {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: book.images.isEmpty ?
                                    "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png"
                                    :  book.images[0])) { image in
                    image.image?.resizable()
                }
                .cornerRadius(10)
                .frame(maxWidth: 90)
                //.frame(minWidth: 90)
                .clipped()
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: -2, y: 2)
                
                VStack(alignment: .leading, spacing: 14) {
                    Text(book.title)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)

                    Text("\(author.name) \(author.surname)")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        
                    }) {
                        Text(genre.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 3)
                            .background(Color.gray.opacity(0.3))
                            .foregroundColor(Color.black.opacity(0.7))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.leading, 15)
                .frame(width: 185)
                
                Spacer()
                
                VStack {
                    HStack(spacing: 1.5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 18))
                            .bold()
                        
                        Text(String(format: "%.1f", 5.0))
                            .font(.system(size: 18))
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                            .font(.system(size: 30))
                    }
                    .padding(.bottom, 5)
                }
                .frame(width: 55)
            }
            .frame(maxHeight: 130)
            .padding(15)
            .background(Color.white)
            .cornerRadius(15)

    }
}

#Preview {
    MainView()
    //BookCardView(book: Book(), author: Author(), genre: Genre())
}
