//
//  articleView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/9/24.
//

import SwiftUI

struct WikipediaThumbnail: View {
    @ObservedObject var question : Question
    var body: some View {
        VStack (spacing:0){
            ArticleTopBar()
            ZStack{
                RoundedRectangle(cornerRadius:20)
                    .strokeBorder(.white, lineWidth:  1)
                    .shadow(radius: 10)
                WebView(url: question.link)
            }
        }
        .frame(minHeight:200)
    }
}

struct ArticleTopBar: View {
    var body: some View{
            VStack (spacing:0){
                Rectangle()
                    .fill(.white)
                    .frame(height:50)
                    .overlay(
                        HStack {
                            Spacer()
                                .frame(width: 30)
                            Text("Article View")
                                .font(.title2)
                            Spacer()
                        }
                            .offset(y:-10),
                        alignment: .bottom
                )
            Divider()
        }
    }
}

#Preview {
    WikipediaThumbnail(question:example)
}
