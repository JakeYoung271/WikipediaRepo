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
    let id: UUID
    init(q:Question){
        id = UUID()
        question = q
        items = optionsWrapper(question: q, inert : true)
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
                WikipediaThumbnail(question:question)
                //Text("This is a placeholder for a wiki Article")
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
    InertQuestion(q:example)
        .padding()
}

//
//
//
