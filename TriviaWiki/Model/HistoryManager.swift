//
//  HistoryManager.swift
//  TriviaWiki
//
//  Created by Jake Young on 5/30/24.
//

import Foundation

class HistoryManager {
    static let shared = HistoryManager()
    var seen: [String: [String: Any]]
    var sessionHistory: [Int: Question]
    var ratings : [Int]
    private init(){
        ratings = [1200,1200,1200]
        sessionHistory = [Int: Question]()
        seen = [String:[String:Any]]()
        initializeHistoryManager()
    }
    func see(q:Question){
        seen[String(q.id)] = q.makeDict()
        sessionHistory[q.id] = q
    }
    func updateRatings(q:Question){
        //to be implements
    }
    func seen(id:Int) -> Bool{
        return sessionHistory[id] != nil || seen[String(id)] != nil
    }
    
    func initializeHistoryManager(){
        if findJSON(name: "HistoryManager"){
            let data = readJSON(name: "HistoryManager")!
            seen = data["history"] as! [String: [String: Any]]
            ratings = data["ratings"] as! [Int]
        }
    }
    func save(){
        let data = ["history" : seen, "ratings": ratings] as [String : Any]
        writeJSON(name: "HistoryManager", data: data)
    }
}
