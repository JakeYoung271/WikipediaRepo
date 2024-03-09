//
//  QuestionModel.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import Foundation
import SwiftUI
class Question: ObservableObject{
    let id: Int
    let link: String
    let question: String
    let options: [String]
    let responseRates: [CGFloat]
    let correctIndex: Int
    let subject: String
    let difficulty: Double
    @Published var selectedIndex: Int
    @Published var complete: Bool
    @Published var timeOnScreen: Double
    @Published var clicks: Double
    @Published var article : WebView
    
    init(){
    id = 0
    link =  "https://en.wikipedia.org/wiki/Twitter"
    question = "Who is the current CEO of twitter?"
    options = ["Donald Trump","Elon Musk", "Darth Vader", "Neil Gaiman"]
    responseRates = [0.50,0.25,0.125,0.125]
    correctIndex = 1
    subject = "business"
    difficulty = 0.5
    selectedIndex = 5
    complete = false
    timeOnScreen = 0.1
    clicks = 0.0
    article = WebView(url:link)
    }
    
}
