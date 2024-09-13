//
//  QuestionModel.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import Foundation
import SwiftUI

var example = Question()

class QuestionFactory {
    var questions : [Int: Question]
    static var shared = QuestionFactory()
    private init(){
        questions = [Int:Question]()
    }
    func getQuestion(id: Int) -> Question{
        if let foundQuestion = questions[id] {
          return foundQuestion
        } else {
            let newQuestion = Question(id1: id)
            questions[id] = newQuestion
            return newQuestion
            
        }
    }
}

class Question: ObservableObject, Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    func hash(into hasher: inout Hasher){
        hasher.combine(ObjectIdentifier(self))
    }
    let ref = DataManager.shared
    let id: Int
    let link: String
    let question: String
    let options: [String]
    let responseNums: [Int]
    let correctIndex: Int
    let topic : String
    let quote : String
    @Published var complete: Bool
    @Published var revealedHint: Bool
    @Published var selectedIndex: Int?
    @Published var liked: Bool?
    @Published var report: String?
    
    init(){
        id = 0
        link =  "https://en.wikipedia.org/wiki/default"
        question = "This is the default question, if you are seeing this, there is a bug. Please report it in your profile"
        options = ["Cockroach","Fly", "Termite", "Beatle"]
        correctIndex = 1
        complete = false
        revealedHint = false
        responseNums = [0,0,0,0]
        topic = "default"
        quote = "In this example, defaultApp is the default Firebase app, and secondaryApp is another Firebase app connected to a different Firebase project. You can then use defaultDb and secondaryDb to interact with the respective Firestore databases."
    }
    
    init(id1 : Int){
        id = id1
        link = ref.getQuestion_link(id: id1)
        question = ref.getQuestion_question(id: id1)
        options = ref.getQuestion_options(id: id1)
        correctIndex = ref.getQuestion_correctIndex(id: id1)
        complete = ref.getQuestion_complete(id: id1)
        revealedHint = ref.getQuestion_revealedHint(id: id1)
        responseNums = ref.getQuestion_responseNums(id: id1)
        topic = ref.getQuestion_topic(id: id1)
        quote = ref.getQuestion_quote(id: id1)
        selectedIndex = ref.getQuestion_selectedIndex(id: id1)
        liked = ref.getQuestion_liked(id: id1)
        report = ref.getQuestion_report(id: id1)
    }

    func like() -> Void {
        if liked == true {
            liked = nil
        } else {
            liked = true }
        ref.seeQuestion(id: id)
        return
    }
    func dislike() -> Void {
        if liked == false {
            liked = nil
        } else {
            liked = false }
        ref.seeQuestion(id: id)
        return
    }
    func reportQuestion(reason: String) -> Void {
        ref.seeQuestion(id: id)
        report = reason
    }
    func selectAnswer(selection: Int) -> Void {
        ref.seeQuestion(id: id)
        selectedIndex = selection
        complete = true
        ref.applyRatingChange(q: self)
    }
    func reveal() -> Void {
        ref.seeQuestion(id: id)
        revealedHint = true
        ref.applyRatingChange(q: self)
    }
    func completedCorrectly() -> Bool {
        return (selectedIndex == correctIndex) && (!revealedHint)
    }
    func serializeData() -> [String: Any]{
        var result = [String: Any]()
        result["id"] = id
        if let liked1 = liked {
            result["liked"] = liked1
        }
        if let report1 = report {
            result["report"] = report1
        }
        if let selected = selectedIndex {
            result["selectedIndex"] = selected
        }
        result["complete"] = complete
        result["revealedHint"] = revealedHint
        return result
    }
}
