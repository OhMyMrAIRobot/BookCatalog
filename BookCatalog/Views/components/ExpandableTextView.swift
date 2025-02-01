//
//  ExpandableTextView.swift
//  BookCatalog
//
//  Created by Daniil on 1.02.25.
//

import SwiftUI

struct ExpandableTextView: View {
    let fullText: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(isExpanded ? fullText : limitedText)
                .lineLimit(isExpanded ? nil : 5)
                .padding(.bottom, 1)
                .animation(.smooth.speed(4), value: isExpanded)
            
            Button(isExpanded ? "Less" : "More") {
                isExpanded.toggle()
            }
            .font(.headline)
            .foregroundColor(Color(.red).opacity(0.8))
        }
    }

    var limitedText: String {
        let lines = fullText.components(separatedBy: .newlines)
        let visibleLines = lines.prefix(5).joined(separator: "\n")
        return lines.count > 5 ? visibleLines : fullText
    }
}

#Preview {
    let longText = "A journey through the otherworldly science behind Christopher Nolan’s award-winning film, Interstellar, from executive producer and Nobel Prize-winning physicist Kip Thorne. Interstellar, from acclaimed filmmaker Christopher Nolan, takes us on a fantastic voyage far beyond our solar system. Yet in The Science of Interstellar, Kip Thorne, the Nobel prize-winning physicist who assisted Nolan on the scientific aspects of Interstellar, shows us that the movie’s jaw-dropping events and stunning, never-before-attempted visuals are grounded in real science. Thorne shares his experiences working as the science adviser on the film and then moves on to the science itself. In chapters on wormholes, black holes, interstellar travel, and much more, Thorne’s scientific insights ― many of them triggered during the actual scripting and shooting of Interstellar ― describe the physical laws that govern our universe and the truly astounding phenomena that those laws make possible."

    return ExpandableTextView(fullText: longText)
}
