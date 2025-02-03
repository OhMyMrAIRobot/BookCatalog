//
//  ReviewView.swift
//  BookCatalog
//
//  Created by Daniil on 3.02.25.
//

import SwiftUI

struct ReviewView: View {
    let review: Review
    let profile: Profile
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.name.isEmpty && profile.surname.isEmpty ?
                         "Unknown user"
                         : "\(profile.name) \(profile.surname)")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    
                    Text(review.date.dateValue().formatted(date: .numeric, time: .omitted))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < review.rating ? "star.fill" : "star")
                            .bold()
                            .foregroundColor(index < review.rating ? .yellow : .gray)
                    }
                }
            }
            
            ExpandableTextView(fullText: review.text, lines: 3)
            
            Divider()
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}

#Preview {
    ReviewView(review: Review(
        bookId: "123", rating: 4, text: "Displaying dates in SwiftUI has been made so easy now, that there is almost no reason to use DateFormatter anymore to display dates in SwiftUI. We will go over several examples to show how powerful this API has become, and there are more configurations that we aren’t going to show here. Hopefully, this article encourages you to check out everything you can do with dates and times in your app."),
        profile: Profile(id: "123", email: "email", age: 56))
}
