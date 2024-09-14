//
//  WikiArticleThumbnailView.swift
//  TriviaWiki
//
//  Created by Jake Young on 5/27/24.
//

import SwiftUI

struct WikiArticleThumbnailView: View {
    var question : Question
    var body: some View {
            Image("WikipediaFrame")
                .resizable()
                .scaledToFit()
                .overlay{
                    VStack {
                        Spacer()
                            .frame(height:10)
                        HStack {
                                Spacer()
                                Text(getTitle())
                                    .font(.custom("texgyretermes-regular", size:30))
                                    .offset(y: -5)
                                    .foregroundStyle(.black)
                                Spacer()
                                .frame(width:15)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Text("(Tap Card To Reveal Article)       ")
                                .offset(y:-10)
                                .foregroundStyle(.black)
                        }
                    }
                        Spacer()
                    VStack{
                        Text(question.quote)
                            .lineLimit(4)
                            .truncationMode(.tail)
                            .font(.custom("texgyretermes-regular", size:20))
                            .padding(.horizontal, 10)
                            .foregroundStyle(.black)
                            .opacity(0.85)
                    }

                }
    }
    func getTitle() -> String {
        var result = question.topic
        if result.count > 15{
            let index = result.index(result.startIndex, offsetBy: 13)
            result = String(result.prefix(upTo: index)) + "..."
        }
        return result
    }
}
