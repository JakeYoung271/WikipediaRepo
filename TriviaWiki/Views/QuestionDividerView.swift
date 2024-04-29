//
//  QuestionDividerView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/18/24.
//

import SwiftUI

import Popovers

struct QuestionDividerView: View, Identifiable {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    @State var notRated = true
    @State var report = false
    @State var notReported = true
    @State var enjoyed : Bool?
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
                HStack {
                    Text(question.question).font(.custom("texgyretermes-regular", size:25))
                        .multilineTextAlignment(.leading)
                }
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
            VStack{
                Spacer()
                if question.complete {
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                    .frame(height:50)
                                Button (action: {report.toggle()}) {
                                    Image(systemName: "exclamationmark.bubble")
                                        .font(.title2)
                                        .padding(15)
                                        .background(
                                            Circle()
                                                .fill(.white)
                                                .padding(5)
                                                .background(
                                                    Circle()
                                                        .fill(.blue)
                                                        .opacity(0.5)))}
                                
                                Spacer()
                            Spacer()
                                .frame(width:20)
                        }
                    }
                }
                if question.complete && notRated {
                    LikeDislikeMenu(likeAction: {like()}, dislikeAction: {dislike()})
                        .frame(maxWidth:25)
                }
                if let enjoyed = enjoyed {
                    if enjoyed {
                        HStack {
                            Spacer()
                            Image(systemName: "hand.thumbsup.circle")
                                .font(.system(size: 40))
                                .padding(5)
                                .background(
                                Circle()
                                    .fill(.green)
                                    .opacity(0.5))
                        }
                    }
                    else {
                        HStack {
                            Spacer()
                            Image(systemName: "hand.thumbsdown.circle")
                                .font(.system(size: 40))
                                .padding(5)
                                .background(
                                Circle()
                                    .fill(.red)
                                    .opacity(0.5))
                        }
                        
                    }
                }
            }
            if report {
                ReportMenu(questionID: question.id, notReported: notReported, exitAction: {report = false}, submitAction: {notReported = false})
                    .fixedSize()
            }
            }
        }
   func like(){
        notRated = false
        enjoyed = true
       print("liked")
       fbase.pub.addResponse(id: question.id, likedQ: true)
    }
    func dislike(){
        notRated = false
        enjoyed = false
        print("disliked")
        fbase.pub.addResponse(id: question.id, likedQ: false)
    }
}

#Preview {
    QuestionDividerView(q: example)
}
