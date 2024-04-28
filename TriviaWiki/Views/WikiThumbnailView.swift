//
//  WikiThumbnailView.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/27/24.
//

import SwiftUI

struct WikiThumbnailView: View {
    var subject : String
    var body: some View {
        ZStack {
            Image(.wikiThumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
            //.padding(10)
            HStack {
                Text(subject)
                    .font(.custom("texgyretermes-regular", size:30))
                    .offset(x:10, y: 5)
                    .foregroundColor(.black)
                    .opacity(0.7)
                Spacer()
            }
                Text("(tap to reveal article)")
                .offset(x:70, y: 55)
                .foregroundColor(.gray)
        }
        
    }
}

#Preview {
    WikiThumbnailView(subject:"Math")
}
