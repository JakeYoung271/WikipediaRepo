//
//  QuestionDividerView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/18/24.
//

import SwiftUI

import SwiftUI
import Combine

struct QuestionDividerView: View {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    var timer = Timer()
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
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
                items.assignTimer()
        }
        }
    }
}

#Preview {
    QuestionDividerView(question: example, items: optionsWrapper(question:example))
}
