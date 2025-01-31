//
//  FilterModalView.swift
//  BookCatalog
//
//  Created by Daniil on 31.01.25.
//

import SwiftUI

struct FilterModalView: View {
    @Binding var isPresented: Bool
    @State private var selectedGenre: String = "All"
    @State private var selectedAge: Int = 0

    
    var body: some View {
        NavigationView {
            VStack {

                Stepper("Minimum Age: \(selectedAge)+", value: $selectedAge, in: 0...18)
                    .padding()

                Spacer()
                
                Button("Apply Filters") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
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
