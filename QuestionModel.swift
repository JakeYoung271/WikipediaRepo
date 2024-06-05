//
//  QuestionModel.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import Foundation
import SwiftUI

var example = Question()

class questionFactory {
    static let shared = questionFactory()
    var ids : Set<Int>
    var questionCache : [Int: Question]
    private init(){
        ids = Set<Int>()
        questionCache = [Int: Question]()
    }
    func getQuestion(id: Int) -> Question {
        if ids.contains(id){
            return questionCache[id]!
        }
        var toReturn = Question(id1: id)
        if let data = HistoryManager.shared.seen[String(id)] as? [String: Any] {
            toReturn.selectedIndex = data["selected"] as! Int
            toReturn.sawHint = data["revealed"] as! Bool
            if toReturn.selectedIndex < 4 {
                toReturn.complete = true
            }
            if let liked = data["liked"] as? Bool{
                toReturn.liked = liked
            }
            if let report = data["report"] as? String{
                toReturn.reported = report
            }
        }
        ids.insert(id)
        questionCache[id] = toReturn
        return toReturn
    }
}

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
    //@Published var clicks: Double
    @Published var liked: Bool?
    @Published var reported: String?
    @Published var sawHint = false
    
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
        //clicks = 0.0
        responseNums = [0,0,0,0]
        topic = "default"
        quote = "In this example, defaultApp is the default Firebase app, and secondaryApp is another Firebase app connected to a different Firebase project. You can then use defaultDb and secondaryDb to interact with the respective Firestore databases."
    }
    
    init(id1 : Int){
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
        //clicks = 0.0
        responseNums = DataManager.shared.timesSeen[id1]
        topic = q["topic"] as! String
        quote = q["quote"] as! String
    }
        
    init(id1: Int, topic: String, q: String, opts: [String], resps: [Int], corr: Int, cat: String, diff: Int, mQuote: String){
    id = id1
    link =  "https://en.wikipedia.org/wiki/" + topic.replacingOccurrences(of: " ", with: "_")
    question = q
    options = opts
    correctIndex = corr
    subject = cat
    difficulty = diff
    selectedIndex = 5
    complete = false
    //clicks = 0.0
    responseNums = resps
    self.topic = topic
    quote = mQuote
    }
    
    func complete(index: Int){
        print("RUNNING complete on question with id: \(id), selected index is \(index)")
        complete = true
        selectedIndex = index
        see()
    }
    func report(comment: String){
        print("RUNNING report on question with id: \(id), with comment \(comment)")
        reported = comment
        see()
    }
    func see(){
        HistoryManager.shared.see(q:self)
    }
    func like() -> Void {
        print("LIKED question with id \(id)")
        if liked==nil || liked!==false{
            liked = true
        } else {
            liked = nil
            print("ACTUALLY UNLIKED")
        }
        see()
    }
    func dislike() -> Void {
        print("DISLIKED question with id \(id)")
        if liked==nil || liked!==true{
            liked = false
        } else {
            liked = nil
            print("ACTUALLY UNDISLIKED")
        }
        see()
    }
    
    func makeDict() -> [String: Any]{
        var result : [String: Any] = ["id": id, "selected" : selectedIndex, "revealed": sawHint]
        if let enjoyed = liked {
            result["liked"] = enjoyed
        }
        if let report = reported {
            result["report"] = report
        }
        return result
    }
}
