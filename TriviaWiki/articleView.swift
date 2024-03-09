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
        ZStack {
            RoundedRectangle(cornerRadius:20)
                .strokeBorder(.white, lineWidth:  1)
            .shadow(radius: 10)
            question.article
        }
        .frame(minHeight:200)
    }
}

#Preview {
    WikipediaThumbnail(question:example)
}
