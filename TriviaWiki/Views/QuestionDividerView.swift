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
        items = optionsWrapper(question: q)
    }
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            
            //return here to adjust handling of different text sizes and lengths
            
            VStack {
                Text(question.question).font(.custom("texgyretermes-regular", size:25))
                Spacer(minLength: 20)
                WikipediaThumbnail(question:question)
                    .frame(minHeight:200)
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
