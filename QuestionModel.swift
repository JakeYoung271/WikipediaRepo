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
    let sResult = CoreDataStack.shared.fetchID(id:id1)
    if sResult.count != 1 {
        for i in sResult{
            print(i.question)
        }
        print(sResult.count)
        print("tried to initialize question with fetched ID, failed on question with id \(id1)")
        id = id1
        link =  "https://en.wikipedia.org/wiki/default"
        question = "Failed to Generate Question with id \(id). Guess why the answer options are relevant. Hint (this question is a ..."
        options = ["Cockroach","Fly", "Termite", "Beatle"]
//        responseRates = [0.5,0.5,0.5,0.5]
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
    else{
        let Qbody = sResult[0]
        id = id1
        link =  "https://en.wikipedia.org/wiki/" + (Qbody.topic!).replacingOccurrences(of: " ", with: "_")
        question = Qbody.question!
        options = Qbody.answers!
        correctIndex = Int(Qbody.correct)
        subject = Qbody.category!
        difficulty = 0
        selectedIndex = 5
        complete = false
        clicks = 0.0
        responseNums = allResponses[id1]
        topic = Qbody.topic!
        quote = Qbody.quote!
        }
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
