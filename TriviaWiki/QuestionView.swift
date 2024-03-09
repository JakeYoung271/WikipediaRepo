//
//  QuestionView.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import SwiftUI
var example = Question()


struct QuestionView: View {
    @ObservedObject var question: Question

    var body: some View {
        let timer = Timer.publish(every:1,on:.main,in:.common).autoconnect()
                 ZStack {
                        Rectangle()
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .foregroundStyle(.white)
                        VStack {
                            Text(String(question.timeOnScreen))
                            Text(question.question).font(.title)
                            Divider()
                            WikipediaThumbnail(urlStr: question.link)
                            Spacer(minLength: 20)
                            Divider().foregroundColor(.black)
                            Spacer(minLength: 20)
                            ForEach(0..<question.options.count){x in
                                    QuestionAnswer(question:question, x:x)
                                
                                }
                            }
                        .padding()
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .onReceive(timer) {_ in
                        question.timeOnScreen += 1
                    }
                }
            }

struct WikipediaThumbnail: View {
    var urlStr : String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:20)
                .strokeBorder(.white, lineWidth:  1)
            .shadow(radius: 10)
            WebView(url:urlStr)
        }
        .frame(minHeight:200)
        
    }
}

#Preview {
    QuestionView(question: example)
}
