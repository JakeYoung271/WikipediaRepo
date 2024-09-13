//
//  QuestionDividerView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/18/24.
//

import SwiftUI


struct QuestionMenuView: View, Identifiable {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    @State var report = false
    @State var forSure = false
    @State var showCard = false
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
                Spacer()
                    .frame(height:20)
                ForEach(items.optionsView){x in
                    x
                }
                Spacer()
                    .frame(height:10)
                QuestionMenu(question: question, showHint: $showCard, report: {report.toggle()}, showAreYouSure: {forSure.toggle()})
            }
            .padding(10)
            if report {
                if let _ = question.report {
                    ReportMenu(question: question, notReported: false, exitAction: {report = false}, submitAction: {})
                        .fixedSize()
                } else {
                    ReportMenu(question: question, notReported: true, exitAction: {report = false}, submitAction: {})
                        .fixedSize()
                }
            }
            if forSure {
                AreYouSureView(yes:{forSure.toggle(); showCard = true; question.reveal()}, no: {forSure.toggle()})
                    .padding()
            }
        }
    }
}

struct QuestionMenu: View {
    @ObservedObject var question: Question
    @Binding var showHint : Bool
    let report: () -> Void
    let showAreYouSure: () -> Void
    var body: some View {
        VStack {
            if showHint {
                    NavigationLink(destination:  WebView(url:question.link)
                        .onAppear(perform:{showHint.toggle()})){
                            WikiArticleThumbnailView(question: question)
                    }
            }
            HStack{
                Spacer()
                    .frame(width:5)
                Article(action: {decideToShow()})
                Spacer()
                LikeDislikeMenu(question: question)
                Spacer()
                ReportButton(reportAction: report)
                Spacer()
                    .frame(width:5)
            }
        }
    }
    func decideToShow(){
        if showHint {
            showHint = false
            return
        }
        if question.complete || question.revealedHint {
            showHint.toggle()
        } else {
            showAreYouSure()
        }
    }
}

struct ReportButton: View {
    var reportAction : () -> Void
    var body: some View{
        VStack {
            Button (action: reportAction) {
                Image(systemName: "exclamationmark.bubble")
                    .font(.title2)
                    .padding(18)
                    .background(
                        Circle()
                            .fill(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.blue)
                                    .opacity(0.5)))}
    }
    }
}

struct Article: View {
    var action : () -> Void
    var body: some View{
        VStack {
            Button (action: action) {
                Image(systemName: "newspaper")
                    .font(.title2)
                    .padding(18)
                    .background(
                        Circle()
                            .fill(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.blue)
                                    .opacity(0.5)))}
    }
    }
}

struct Info: View {
    var body: some View{
        VStack {
            Button (action: {}) {
                Image(systemName: "info")
                    .font(.title2)
                    .padding(18)
                    .background(
                        Circle()
                            .fill(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.blue)
                                    .opacity(0.5)))}
    }
    }
}

struct LikeDislikeMenu: View {
    @State var colorUP = Color.white
    @State var colorDOWN = Color.white
    @ObservedObject var question: Question
    var body: some View {
        HStack{
            Button(action: {question.like()}) {
                Image(systemName: "hand.thumbsup")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                        Circle()
                            .fill((question.liked==true) ? Color("LightGreen"):Color.white))
                    .padding(10)
            }
            Button(action: {question.dislike()}) {
                Image(systemName: "hand.thumbsdown")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                    Circle()
                        .fill((question.liked==false) ? Color("LightRed"): Color.white))
                .padding(10)
            }
        }
        .background(
        Rectangle()
            .fill(.blue)
            .cornerRadius(30)
            .opacity(0.5)
            
        )
    }
}

#Preview {
    QuestionMenuView(q:Question())
}
