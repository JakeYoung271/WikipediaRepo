//
//  DisplayList.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/19/24.
//

import Foundation


class DisplayList : ObservableObject {
    var questions : [Question]
    @Published var qViews : [QuestionDividerView]
    var next:Int
    init(l1:[Question]){
        next = 0
        questions = l1
        qViews = [QuestionDividerView]()
    }
    init(){
        next = 0
        questions = [Question]()
        qViews = [QuestionDividerView]()
    }
    func add(q: Question){
        questions.append(q)
        //qViews.append(QuestionDividerView(question:q, items:optionsWrapper(question:q)))
    }
    func loadNext(){
        if next==questions.count{
            return
        }
        print("got here")
        qViews.append(QuestionDividerView(question:questions[next], items:optionsWrapper(question:questions[next])))
        next += 1
    }
}
