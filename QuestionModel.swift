//
//  QuestionModel.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import Foundation
import SwiftUI

var example = Question()

class Question: ObservableObject, Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    func hash(into hasher: inout Hasher){
        hasher.combine(ObjectIdentifier(self))
    }
    
    let id: Int
    let link: String
    let question: String
    let options: [String]
    let responseNums: [Int]
    let correctIndex: Int
    let subject: String
    let difficulty: Int
    let topic : String
    let quote : String
    @Published var selectedIndex: Int
    @Published var complete: Bool
    @Published var clicks: Double
    
    init(){
        id = 0
        link =  "https://en.wikipedia.org/wiki/default"
        question = "This is the default question, if you are seeing this, there is a bug. Please report it in your profile"
        options = ["Cockroach","Fly", "Termite", "Beatle"]
        correctIndex = 1
        subject = "TestQuestion"
        difficulty = 1
        selectedIndex = 5
        complete = false
        //timeOnScreen = 0.1
        clicks = 0.0
        responseNums = [0,0,0,0]
        topic = "default"
        quote = "In this example, defaultApp is the default Firebase app, and secondaryApp is another Firebase app connected to a different Firebase project. You can then use defaultDb and secondaryDb to interact with the respective Firestore databases."
    }
    
    init(id1 : Int){
    if let cQuest = QuestionHistoryManager.pub.IDCache[id1]{
        id = id1
        link = cQuest.link
        question = cQuest.question
        options = cQuest.options
        correctIndex = cQuest.correctIndex
        subject = cQuest.subject
        difficulty = cQuest.difficulty
        selectedIndex = cQuest.selectedIndex
        complete = cQuest.complete
        clicks = cQuest.clicks
        responseNums = cQuest.responseNums
        topic = cQuest.topic
        quote = cQuest.quote
        return
    }
        let q = DataManager.shared.getQuestionN(n: id1)
        id = id1
        link =  "https://en.wikipedia.org/wiki/" + (q["topic"] as! String).replacingOccurrences(of: " ", with: "_")
        question = q["question"] as! String
        options = q["options"] as! [String]
        correctIndex = q["correct"] as! Int
        subject = q["category"] as! String
        difficulty = 0
        selectedIndex = 5
        complete = false
        clicks = 0.0
        responseNums = allResponses[id1]
        topic = q["topic"] as! String
        quote = q["quote"] as! String
    }
    
    
    init(id1: Int, topic: String, q: String, opts: [String], resps: [Int], corr: Int, cat: String, diff: Int){
    id = id1
    link =  "https://en.wikipedia.org/wiki/" + topic.replacingOccurrences(of: " ", with: "_")
    question = q
    options = opts
    correctIndex = corr
    subject = cat
    difficulty = diff
    selectedIndex = 5
    complete = false
    clicks = 0.0
    responseNums = resps
    self.topic = topic
    quote = "In this example, defaultApp is the default Firebase app, and secondaryApp is another Firebase app connected to a different Firebase project. You can then use defaultDb and secondaryDb to interact with the respective Firestore databases."
    }
    func like() -> Void {
        return
    }
    func dislike() -> Void {
        return
    }
}
