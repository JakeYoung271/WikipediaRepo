//
//  SFSymbolTestView.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/28/24.
//

import SwiftUI

struct SFSymbolTestView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Image(systemName: "hand.thumbsup")
    }
}

struct LikeDislikeMenu: View {
    let likeAction : () -> Void
    let dislikeAction : () -> Void
    var body: some View {
        HStack{
            Button(action: likeAction) {
                Image(systemName: "hand.thumbsup")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(.white))
                    .padding(10)
            }
            Button(action: dislikeAction) {
                Image(systemName: "hand.thumbsdown")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                    Circle()
                        .fill(.white))
                .padding(10)
            }
        }
        .background(
        Rectangle()
            .fill(.blue)
            .cornerRadius(30)
            .opacity(0.5)
            
        )
    }
}

#Preview {
    LikeDislikeMenu(likeAction: {print("ran like action")}, dislikeAction: {print("ran dislike")})
}
