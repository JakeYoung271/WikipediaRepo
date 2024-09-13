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

func secondsSince2024() -> Int {
    // 54 * 365.25 * 24 * 60 * 60 = 1704110400
    let displacement = 1704110400.0
    return Int(NSDate().timeIntervalSince1970 - displacement)
}

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
    
    func uploadUserHistory(History: [[String: Any]]) async -> Bool {
        if History.count == 0 {
            return true
        }
        let deviceID = await UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
        let db = Firestore.firestore().collection("userLogs").document(deviceID)
        let time = secondsSince2024()
        let data : [String: Any] = [String(time) : History]
        do {
            try await db.setData(data, merge: true)
            print("UPLOADED \(data)")
            return true
        }
        catch{
            print("ERROR: failed to upload log because of \(error)")
            return false
        }
    }
}
