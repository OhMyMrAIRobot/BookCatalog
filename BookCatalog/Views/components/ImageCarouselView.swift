//
//  ImageCarouselView.swift
//  BookCatalog
//
//  Created by Daniil on 1.02.25.
//

import SwiftUI

struct ImageCarouselView: View {
    var book: Book
    @State private var currentIndex = 0

    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(Array(book.images.enumerated()), id: \.offset) { index, imgUrl in
                    AsyncImage(url: URL(string: imgUrl)) { image in
                        image.image?.resizable()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 380)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % book.images.count
                }
            }

            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        currentIndex = (currentIndex + 1 + book.images.count) % book.images.count
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.2), in: Circle())
                }
                .padding(.leading, 20)
            }

            HStack {
                Button(action: {
                    withAnimation {
                        currentIndex = (currentIndex - 1) % book.images.count
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.2), in: Circle())
                }
                .padding(.trailing, 20)
                Spacer()
            }
        }
        .frame(height: 380)
    }
}



//#Preview {
//    ImageCarouselView(book: Book())
//}
#Preview {
    BookView(bookViewModel: BookViewModel(book: Book(), author: Author(), genre: Genre(), language: BookLanguage()))
}
