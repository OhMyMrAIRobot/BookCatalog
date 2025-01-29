//
//  MainView.swift
//  BookCatalog
//
//  Created by Daniil on 26.01.25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    private var base64String = ""
    var body: some View {
        VStack {
            if let image = decodeBase64Image(base64String) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("Ошибка загрузки изображения")
            }
            Spacer()
            Button{
                AuthService.shared.signOut()
            } label: {
                Text("Sign out")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(.black))
                    .padding()
            }
            NavigationBar(selectedTab: $selectedTab)
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    func decodeBase64Image(_ base64: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: imageData)
    }
}

#Preview {
    MainView()
}
