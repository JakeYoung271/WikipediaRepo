//
//  DisplayList.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/19/24.
//

import Foundation

class DisplayList : ObservableObject {
    var questions : [Question]
    var qViews : [QuestionDividerView]
    init(l1:[Question]){
        questions = l1
        qViews = [QuestionDividerView]()
        for x in l1 {
            qViews.append(QuestionDividerView(question:x, items: optionsWrapper(question:x)))
        }
    }
    init(){
        questions = [Question]()
        qViews = [QuestionDividerView]()
    }
    func add(q: Question){
        questions.append(q)
        qViews.append(QuestionDividerView(question:q, items:optionsWrapper(question:q)))
    }
}
