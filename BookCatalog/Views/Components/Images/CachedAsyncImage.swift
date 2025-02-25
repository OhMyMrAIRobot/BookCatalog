//
//  CachedAsyncImage.swift
//  BookCatalog
//
//  Created by Daniil on 13.02.25.
//

import SwiftUI

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

public struct CachedAsyncImage<Content>: View where Content: View{

    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    public init(url: URL?,
                scale: CGFloat = 1.0,
                transaction: Transaction = Transaction(),
                @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    public var body: some View {
        if let url, let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(url: url,
                scale: scale,
                transaction: transaction) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success (let image) = phase, let url {
            ImageCache[url] = image
        }
        return content(phase)
    }
}
