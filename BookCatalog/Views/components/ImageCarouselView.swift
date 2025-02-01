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

    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
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
        }
        .frame(height: 380)
    }
}



#Preview {
    ImageCarouselView(book: Book())
}
