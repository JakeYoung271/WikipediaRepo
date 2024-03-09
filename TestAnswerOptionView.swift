//
//  AnswerOptionView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

class optionsWrapper: ObservableObject {
    @ObservedObject var mquestion : Question
    var optionsView: [QuestionAnswer]
    var timer : Timer
    init(question:Question){
        timer = Timer()
        mquestion = question
        optionsView = []
        for i in 0..<question.options.count{
            optionsView.append(QuestionAnswer(question: question, x: i))
        }
    }
    func assignTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        mquestion.timeOnScreen += 0.2
         if mquestion.complete&&mquestion.clicks==0 {
             mquestion.clicks = 0.1
         }
         else if mquestion.complete {
             mquestion.clicks+=0.2
         }
        if mquestion.clicks > 2 {
             mquestion.clicks -= 1.5
             if removeOption(){
                 timer.invalidate()
             }
             }
         }
    func removeOption() -> Bool{
        if optionsView.count==1 {
            return true
        }
        if mquestion.correctIndex == optionsView[0].x {
            optionsView.remove(at:1)
        }
        else {
            optionsView.removeFirst()
        }
        return false
    }
}
