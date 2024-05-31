//
//  QuestionView.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import SwiftUI
//import Combine

struct InertQuestion: View {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    @State var report = false
    @State var notReported = true
    @State var showCard = false
    @State var sawCard = false
    let id: UUID
    init(q:Question){
        id = UUID()
        question = q
        items = optionsWrapper(question: q, inert : true)
    }
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .cornerRadius(20)
                
                //return here to adjust handling of different text sizes and lengths
                
                VStack {
                    Text(question.question).font(.custom("texgyretermes-regular", size:25))
                        .multilineTextAlignment(.leading)
                    ForEach(items.optionsView){x in
                        x
                    }
                    QuestionMenu(question: question, showHint: $showCard, report: {report.toggle()}, showAreYouSure: {})
                }
                .padding()
                if report {
                        ReportMenu(questionID: question.id, notReported: notReported, exitAction: {report = false}, submitAction: {notReported = false})
                            .fixedSize()
                }
            }
        }
    }

}

#Preview {
    InertQuestion(q:example)
        .padding()
}
