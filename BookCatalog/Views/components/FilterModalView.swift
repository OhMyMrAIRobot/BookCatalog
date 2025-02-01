//
//  FilterModalView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import SwiftUI

struct FilterModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select Genres")
                    .font(.headline)
                    .padding(.top)
                
                
                    .navigationTitle("Filters")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
}



#Preview {
    FilterModalView(isPresented: .constant(true))
}
