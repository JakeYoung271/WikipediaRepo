//
//  QueryHandler.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/2/24.
//

import Foundation
import Firebase
import FirebaseCore


class fbase {
    static let pub = fbase()
    private init(){
        FirebaseApp.configure()
    }
    func getQsInArr(ids : [Int]) async -> [Question]{
            var result = [Question]()
            let db = Firestore.firestore()
            let qs = db.collection("questions")
        
            do {
                let querySnapshot = try await qs.whereField("id", in: ids).getDocuments()
              for d in querySnapshot.documents {
                print("\(d.documentID) => \(d.data())")
                let ques = Question(id1: d["id"] as! Int,
                                    topic: d["topic"] as! String,
                                    q: d["question"] as! String,
                                    opts: d["options"] as! [String],
                                    resps: d["responses"] as! [Int],
                                    corr: d["correct"] as! Int,
                                    cat: d["category"] as! String,
                                    diff: d["rating"] as! Int)
                  result.append(ques)
              }
            } catch {
              print("Error getting documents: \(error)")
            }
            return result
    }
    func getIDs(cat:String, rat: Int)async ->[(Int,Int)]{
        //IMPLEMENT THIS FUNCTION
        var result = [(Int,Int)]()
        //return result
        //INCORRECT IMPLEMENTATION:
        var indices = Set<Int>()
        for i in 0..<50{
            let ind = Int.random(in:0...1600)
            indices.insert(ind)
        }
        for i in indices{
            result.append((i,Int.random(in:750...2000)))
        }
        return result
    }
    
    func updateOnlineRating(q:Question) async {
        //IMPLEMENT THIS FUNCTION
    }
}
