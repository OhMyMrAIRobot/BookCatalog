//
//  BookView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.

import SwiftUI

struct BookView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @State var isFavorite: Bool = true
    
    var body: some View {
        ScrollView() {
            AsyncImage(url: URL(string: bookViewModel.book.images.isEmpty ?
                                "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png"
                                :  bookViewModel.book.images[0])) { image in
                image.image?.resizable()
            }.frame(maxWidth: 200, maxHeight: 300)
                .clipped()
                .cornerRadius(10)
                .padding(.top, 15)
            
            
            Text(bookViewModel.book.title)
                .frame(maxWidth: 350)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
         
            Text("\(bookViewModel.author.name) \(bookViewModel.author.surname)")
                .font(.system(size: 22))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .padding(.top, 5)
            
            HStack(alignment: .center) {
                HStack(spacing: 1.5) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 24))
                        .bold()
                    
                    Text(String(format: "%.1f", 5.0))
                        .font(.system(size: 24))
                        .bold()
                }.padding(.horizontal, 7)
                
                HStack(spacing: 1.5) {
                    Image(systemName: "exclamationmark.shield.fill")
                        .foregroundColor(getAgeColor(age: bookViewModel.book.ageRestriction))
                        .font(.system(size: 24))
                        .bold()
                    
                    Text("\(bookViewModel.book.ageRestriction)+")
                        .font(.system(size: 24))
                        .bold()
                }
                
                Spacer()
                
                Text(bookViewModel.genre.name)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 3)
                    .background(Color.red.opacity(0.2))
                    .foregroundColor(Color.red.opacity(0.9))
                    .clipShape(Capsule())
                    .padding(.horizontal, 10)
                
            
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.system(size: 30))
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ExpandableTextView(fullText: bookViewModel.book.description)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .padding(.top, 10)
            
            ImageCarouselView(book: bookViewModel.book)
                .padding(.top, 10)
            
        }
       // .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGray6))
        .scrollIndicators(.hidden)
    }
    
    func getAgeColor(age: Int) -> Color {
        switch age {
        case ...6: return .green
        case 7...17: return .orange
        default: return .red
        }
    }
}

#Preview {
    BookView(bookViewModel: BookViewModel(book: Book(), author: Author(), genre: Genre(), language: BookLanguage()))
}
