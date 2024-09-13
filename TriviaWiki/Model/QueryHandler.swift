//
//  QueryHandler.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/2/24.
//

import Foundation
import Firebase
import FirebaseCore
import UIKit

class fbase {
    static let pub = fbase()
    private init(){
    }

    func getRatingsDoc() async {
        let db = Firestore.firestore()
        let docRef = db.collection("ratings").document("currRatings")
        do {
            let document = try await docRef.getDocument()
            if let data = document.data() {
                writeJSON(name: "currRatings", data: data)
                print("Successfully downloaded currRatings")
            }
        } catch {
            print("failed to download ratings because of \(error)")
        }
    }
    
    func uploadUserHistory() async {
        
    }
}
