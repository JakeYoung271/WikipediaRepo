//
//  qRec.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/7/24.
//

import Foundation

class qRec : ObservableObject {
    
    static let pub = qRec()
    let ref = DataManager.shared
    var cIds : [[(Int,Int)]]
    var mode : String
    
    private init() {
        cIds = [[(Int,Int)](),[(Int,Int)](),[(Int,Int)]()]
        mode = "Random"
        setupLists()
    }
    
    func updateMode(newMode : String) -> Bool {
        if newMode != mode {
            mode = newMode
            print("ran mode updator")
            return true
        }
        return false
    }
    
    private func setupLists() {
        for i in 0..<ref.numQuestions
        {
            if !ref.getQuestion_seen(id: i)
            {
                let index = ref.getQuestion_cat(id: i)
                cIds[index].append((i,ref.getQuestion_rating(id: i)))
            }

        }
        print("Sorting lists in qRec.setupLists")
        cIds[0].sort(by: {$0.1 < $1.1})
        cIds[1].sort(by: {$0.1 < $1.1})
        cIds[2].sort(by: {$0.1 < $1.1})
        print("lists filled and sorted!")
        print(cIds[0].count)
        print(cIds[1].count)
        print(cIds[2].count)
    }
    
    func getBestInCat(catIndex : Int) -> Int{
        var result = -1
        let targetRating = ref.getUserRating(cat: catIndex)
        var a = 0
        var b = cIds[catIndex].count-1
        var target = 0
        while a < b{
            target  = (a + b) / 2
            let val =  cIds[catIndex][target].1
            if val == targetRating {
                a = b
            }
            else if val < targetRating {
                a = target + 1
            }
            else {
                b = target - 1
            }
        }
        var maxScore = -10000
        var maxIndex = 0
        for i in 0...10{
            var score = 0
            let candInd = -5 + target + i
            if candInd > 0 && candInd < cIds[catIndex].count {
                score -= abs(targetRating - cIds[catIndex][candInd].1)
                //sets a penalty for more played questions: preferentially recommends less seen questions
                let timesPlayed = ref.getQuestion_timesPlayed(id: cIds[catIndex][candInd].0)
                if timesPlayed > 100{
                    score -= 50
                }
                else if timesPlayed > 50{
                    score -= 15
                }
                else if timesPlayed > 10 {
                    score -= 5
                }
                score += Int.random(in: 0...50)
                if score > maxScore{
                    maxScore = score
                    maxIndex = candInd
                }
            }
        }
        result = cIds[catIndex][maxIndex].0
        cIds[catIndex].remove(at:maxIndex)
        return result
    }
    
    func recommend() ->Int {
        if mode=="Random" {
            var index = Int.random(in:0...2)
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                index += 1
                index %= 3
            }
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                index += 1
                index %= 3
            }
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                print("they're all empty, holy heck!!!")
                return -1
            }
            return getBestInCat(catIndex: index)
        }
        else {
            var index : Int
            switch (mode){
            case "Science":
                index = 0
            case "Social Studies":
                index = 1
            case "Arts and Culture":
                index = 2
            default:
                index = -1
            }
            if cIds[index].count==0{
                print("cIds of \(index) is empty!!!")
                return -1
            }
            return getBestInCat(catIndex: index)
        }
    }
}
