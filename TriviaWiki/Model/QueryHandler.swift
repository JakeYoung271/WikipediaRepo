//
//  QueryHandler.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/2/24.
//

import Foundation
import Firebase

func getAllQuestions() async ->[Question]{
    var result = [Question]()
    let db = Firestore.firestore()
    let qs = db.collection("questions")
    
    do {
      let querySnapshot = try await qs.getDocuments()
      for d in querySnapshot.documents {
        print("\(d.documentID) => \(d.data())")
        let ques = Question(id1: d["id"] as! Int,
                            topic: d["topic"] as! String,
                            q: d["question"] as! String,
                            opts: d["answers"] as! [String],
                            resps: [0.25, 0.25, 0.25, 0.25],
                            corr: d["correct"] as! Int,
                            cat: d["category"] as! String,
                            diff: 1)
          result.append(ques)
      }
    } catch {
      print("Error getting documents: \(error)")
    }
    return result
}

//Question(id1: d["id"], topic: d["topic"], q: d["question"],opts: d["answers"], resps: [0.25,0.25,0.25,0.25],corr: d["correct"], cat: d["category"], diff: d["difficulty"])
