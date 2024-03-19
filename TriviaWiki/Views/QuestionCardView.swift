//
//  QuestionView.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import SwiftUI
import Combine

struct QuestionCardView: View {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    var timer = Timer()
    var body: some View {
            ZStack {
                    Rectangle()
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .foregroundStyle(.white)
                NavigationView {
                VStack {
                    NavigationLink(destination:WikipediaThumbnail(question:question)){
                        WikipediaThumbnail(question:question)
                        }
                        .frame(minHeight:200)
                        Divider().foregroundColor(.black)
                        Spacer(minLength: 20)
                    Text(question.question).font(.custom("texgyretermes-regular", size:25))
                    Divider()
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
            .frame(width: 360, height:700)
    }
}
#Preview {
    QuestionCardView(question: example, items: optionsWrapper(question:example))
}

//
//
//
