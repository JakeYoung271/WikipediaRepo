//
//  QuestionDividerView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/18/24.
//

import SwiftUI

import SwiftUI

struct QuestionDividerView: View, Identifiable {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    let id: UUID
    init(q:Question){
        id = UUID()
        question = q
        items = optionsWrapper(question: q, inert : false)
    }
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(20)
            
            //return here to adjust handling of different text sizes and lengths
            
            VStack {
                Text(question.question).font(.custom("texgyretermes-regular", size:25))
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 20)
                //Divider()
                NavigationLink(destination: WikipediaThumbnail(question:question)) {
                    WikiThumbnailView(subject: question.topic)
                }
                //Divider()
                Spacer(minLength: 20)
                ForEach(items.optionsView){x in
                    x
                }
            }
            .padding()
            .onAppear(){
        }
        }
    }
}

#Preview {
    QuestionDividerView(q: example)
}
