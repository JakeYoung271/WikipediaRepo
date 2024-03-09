//
//  QuestionView.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import SwiftUI
import Combine

struct testQuestionView: View {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    var timer = Timer()
    var body: some View {
            ZStack {
                Rectangle()
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .foregroundStyle(.white)
                VStack {
                    Text(question.question).font(.custom("texgyretermes-regular", size:30))
                    Divider()
                    WikipediaThumbnail(question:question)
                    Spacer(minLength: 20)
                    Divider().foregroundColor(.black)
                    Spacer(minLength: 20)
                    ForEach(items.optionsView){x in
                        x
                    }
                }
                .padding()
            }
            .padding()
            .onAppear(){
                items.assignTimer()
        }
    }
}
#Preview {
    testQuestionView(question: example, items: optionsWrapper(question:example))
}

